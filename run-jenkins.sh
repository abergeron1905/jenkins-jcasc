#!/bin/bash

# Script de lancement pour Jenkins JCasC avec Podman

# 1. Nom du conteneur et volume
CONTAINER_NAME="mon-jenkins"
VOLUME_NAME="jenkins-data"
IMAGE_NAME="jenkins-jcasc"

# 2. Vérification et création du volume s'il n'existe pas
if ! podman volume exists "$VOLUME_NAME"; then
    echo "📦 Création du volume Podman : $VOLUME_NAME..."
    podman volume create "$VOLUME_NAME"
fi

# 3. Suppression de l'ancien conteneur s'il existe (évite les conflits de nom)
if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "🛑 Un conteneur nommé '$CONTAINER_NAME' existe déjà. Arrêt et suppression en cours..."
    podman stop "$CONTAINER_NAME"
    podman rm "$CONTAINER_NAME"
fi

# 4. Lancement du nouveau conteneur
echo "🚀 Lancement de Jenkins..."
podman run -d \
  --name "$CONTAINER_NAME" \
  -p 8080:8080 \
  -p 50000:50000 \
  -v "${VOLUME_NAME}:/var/jenkins_home:Z" \
  "$IMAGE_NAME"

# 5. Confirmation
if [ $? -eq 0 ]; then
    echo "✅ Jenkins a démarré avec succès !"
    echo "🌐 Accédez à l'interface sur : http://localhost:8080"
else
    echo "❌ Échec du démarrage du conteneur."
fi
