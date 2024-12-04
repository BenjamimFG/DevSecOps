FROM jenkins/jenkins:lts

USER root

RUN apt-get update
RUN apt-get install python3 python3-pip -y

# Install bandit
RUN apt-get -y install bandit

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.58.0

RUN apt-get install wget -y

# Install gitleaks from github release
RUN wget -qO gitleaks.tar.gz https://github.com/gitleaks/gitleaks/releases/download/v8.21.2/gitleaks_8.21.2_linux_x64.tar.gz
RUN tar xf gitleaks.tar.gz -C /usr/local/bin gitleaks

