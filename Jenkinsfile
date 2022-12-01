pipeline {
    agent any
    tools {
        nodejs 'NodeJS 19.2.0'
    }
    stages {
        stage("Test App"){
            steps{
                echo "testing app..."
                sh 'cd /app'
                sh 'npm test'
            }
        }
        stage("Build App Image"){
            steps{
                echo "building app..."
            }
        }
        stage("Push Image to Docker Hub"){
            steps{
                echo "pushing image..."
            }
        }
    }
}