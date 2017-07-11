# webapp-sonarqube
Azure Web Applications on Linux support the deploying of standard Docker containers. However, once a normal container has been deployed, the Kudu software (which is very useful to access and debug issues with the container) is not able to connect via SSH with the container. 

To enable that, an SSH server must be enabled in port 2222, as explained in https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-ssh-support.

This repo modifies the official SonarQube 6.4 scripts to deploy the same SonarQube image alongside with the SSH Server available in port 2222 for Kudu to connect to the repo.