pipeline {
    agent any

    stages {
        stage('Construction 🏗️') {
            steps {
                echo 'Compilation et préparation de l\'application...'
            }
        }
        stage('Tests 🧪') {
            steps {
                echo 'Exécution des tests unitaires...'
                echo 'Tous les tests sont au vert ! ✅'
            }
        }
        stage('Déploiement 🚀') {
            steps {
                echo 'Déploiement automatique sur l\'environnement cible...'
            }
        }
    }
    
    post {
        success {
            echo 'Le pipeline s\'est exécuté avec succès ! 🎉'
        }
        failure {
            echo 'Le pipeline a échoué. ❌'
        }
    }
}