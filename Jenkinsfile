// these values are configured on a per-project basis:
dockerRepoHost = 'docker.io'
dockerRepoUser = 'kingdonb' // (this User must match the value in jenkinsDockerSecret)
dockerRepoProj = 'jenkins'

// these refer to a Jenkins secret (by secret "id"), can be in Jenkins global scope:
jenkinsDockerSecret = 'docker-registry-admin'

// blank values that are filled in by pipeline steps below:
gitCommit = ''
imageTag = ''

pipeline {
  agent {
    kubernetes { yamlFile "jenkins/docker-pod.yaml" }
  }
  stages {
    // Build a Docker image and keep it locally for now
    stage('Build') {
      steps {
        container('docker') {
          script {
            gitCommit = env.GIT_COMMIT.substring(0,8)
            imageTag = sh (script: "./jenkins/image-tag.sh", returnStdout: true)
          }
          sh """\
          #!/bin/sh
          export DOCKER_REPO_USER="${dockerRepoUser}"
          export DOCKER_REPO_HOST="${dockerRepoHost}"
          export DOCKER_REPO_PROJ="${dockerRepoProj}"
          export GIT_COMMIT="${gitCommit}"
          ./jenkins/docker-build.sh
          """.stripIndent()
        }
      }
    }
    stage('Push') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
          credentialsId: jenkinsDockerSecret,
          usernameVariable: 'DOCKER_REPO_USER',
          passwordVariable: 'DOCKER_REPO_PASSWORD']]) {
          container('docker') {
            sh """\
            #!/bin/sh
            export DOCKER_REPO_USER DOCKER_REPO_PASSWORD
            export DOCKER_REPO_HOST="${dockerRepoHost}"
            export DOCKER_REPO_PROJ="${dockerRepoProj}"
            export GIT_COMMIT="${gitCommit}"
            ./jenkins/docker-push.sh
            """.stripIndent()
          }
        }
      }
    }
    stage('Push Tag') {
      when {
        branch 'main'
      }
      steps {
        container('docker') {
          withCredentials([[$class: 'UsernamePasswordMultiBinding',
            credentialsId: jenkinsDockerSecret,
            usernameVariable: 'DOCKER_REPO_USER',
            passwordVariable: 'DOCKER_REPO_PASSWORD']]) {
            sh """\
            #!/bin/sh
            export DOCKER_REPO_USER DOCKER_REPO_PASSWORD
            export DOCKER_REPO_HOST="${dockerRepoHost}"
            export DOCKER_REPO_PROJ="${dockerRepoProj}"
            export GIT_COMMIT="${gitCommit}"
            export GIT_TAG_REF="${imageTag}"
            ./jenkins/docker-hub-tag-success-push.sh
            """.stripIndent()
          }
        }
      }
    }
  }
}
