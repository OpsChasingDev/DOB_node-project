pipeline {
    agent any
    tools {
        nodejs 'NodeJS 19.2.0'
    }
    stages {
        stage("Test App"){
            steps {
                script {
                    dir("app") {
                        echo "testing app..."
                        sh 'npm install'
                        sh 'npm test --prefix /var/jenkins_home/workspace/node-project/app'
                    }
                }
            }
        }
        stage("Build App Image"){
            steps {
                script {
                    echo "building app docker image..."
                    sh 'docker build -t opschasingdev/dockerhub:node-app-1.0.0 .'
                }
            }
        }
        stage("Push Image to Docker Hub"){
            steps {
                echo "pushing image..."
            }
        }
    }
}