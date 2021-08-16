# jenkins-lts-image

Keeping with the advice from [jenkinsci/helm-charts](https://github.com/jenkinsci/helm-charts/blob/461981145e21280b3487a3fece356e1b7d4ed03e/charts/jenkins/README.md#consider-using-a-custom-image), which currently suggest:

> for production use cases one should consider to build a custom Jenkins image which has all required plugins pre-installed

This configuration is preferable to installing plugins at run-time as the plugin server could be down, or plugin installations might fail and reverting to an earlier version or referring to what version was automatically installed might become necessary at some time. Moreover, a straightforward mechanism for promoting plugin updates that does not require anyone to edit YAML by hand, or accept any pull requests from something like  Renovate Bot.

This repo is minimally configured to be able to build current images for Jenkins on a schedule, with a tag format that is compatible with Flux v2's Image Update Automation. For more info on [sortable image tags](https://fluxcd.io/docs/guides/sortable-image-tags/), read through [Automated image updates to Git](https://fluxcd.io/docs/guides/image-update/) in the [Flux Documentation](https://fluxcd.io/docs/) on [fluxcd.io](https://fluxcd.io/)!
