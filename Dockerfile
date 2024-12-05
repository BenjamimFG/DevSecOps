FROM jenkins/jenkins:2.479.2-lts

SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

USER root

# Install Python and dependencies
RUN ["apt-get", "update"]
RUN apt-get install python3-full wget -y

# Install Bandit
RUN cd ~ && python3 -m venv bandit-env
RUN source ~/bandit-env/bin/activate && pip install bandit
RUN ln -s ~/bandit-env/bin/bandit /usr/bin/bandit

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.58.0

# Install gitleaks from github release
RUN wget -qO gitleaks.tar.gz https://github.com/gitleaks/gitleaks/releases/download/v8.21.2/gitleaks_8.21.2_linux_x64.tar.gz
RUN tar xf gitleaks.tar.gz -C /usr/local/bin gitleaks

