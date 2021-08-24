FROM jenkins/jenkins:lts
RUN jenkins-plugin-cli --plugins \
	kubernetes \
	workflow-aggregator \
	git \
	configuration-as-code \
	authorize-project \
	github-oauth \
	command-launcher \
	jdk-tool \
	job-dsl \
	strict-crumb-issuer
