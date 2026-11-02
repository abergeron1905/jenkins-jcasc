FROM docker.io/jenkins/jenkins:lts

# Désactiver l'assistant de configuration initial dans l'interface Web
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Indiquer à Jenkins où trouver le fichier de configuration YAML
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"

# Copier la liste des extensions et les installer
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copier le fichier de configuration as code
COPY --chown=jenkins:jenkins jenkins.yaml /var/jenkins_home/jenkins.yaml