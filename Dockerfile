FROM docker.io/jenkins/jenkins:lts

# Désactiver l'assistant de configuration initial
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Indiquer à Jenkins le nouveau nom du fichier YAML
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"

# Copier et installer les extensions
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copier le fichier de configuration (renommé en jenkins.yaml)
COPY --chown=jenkins:jenkins jenkins.yaml /var/jenkins_home/jenkins.yaml