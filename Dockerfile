FROM jenkins/jenkins:lts

USER root

# Install Bandit and basic dependencies
RUN apt-get update && apt-get install python3 python3-pip bandit wget -y

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.58.0

# Install gitleaks from github release
RUN wget -qO gitleaks.tar.gz https://github.com/gitleaks/gitleaks/releases/download/v8.21.2/gitleaks_8.21.2_linux_x64.tar.gz
RUN tar xf gitleaks.tar.gz -C /usr/local/bin gitleaks

RUN jenkins-plugin-cli --plugins defectdojo:1.064.v65b_f28b_4a_fea_

