#!/bin/bash
CONTAINER_NAME="mon-jenkins"
VOLUME_NAME="jenkins-data"
# On utilise la nomenclature standard locale de Podman
IMAGE_NAME="localhost/jenkins-jcasc:latest"

if ! podman volume exists "$VOLUME_NAME"; then
    echo "📦 Création du volume Podman..."
    podman volume create "$VOLUME_NAME"
fi

if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "🛑 Nettoyage de l'ancien conteneur..."
    podman stop "$CONTAINER_NAME"
    podman rm "$CONTAINER_NAME"
fi

echo "🏗️ Construction de l'image Jenkins (JCasC)..."
# On build directement avec le tag complet localhost/
podman build -t "$IMAGE_NAME" .

echo "🚀 Lancement de Jenkins..."
# On utilise la variable nettoyée (sans containers-storage:)
podman run -d \
  --name "$CONTAINER_NAME" \
  -p 8080:8080 \
  -p 50000:50000 \
  -v "${VOLUME_NAME}:/var/jenkins_home" \
  "$IMAGE_NAME"

if [ $? -eq 0 ]; then
    echo "✅ Jenkins a démarré avec succès !"
    echo "🌐 Ouvrez votre navigateur Windows sur : http://localhost:8080"
fi
