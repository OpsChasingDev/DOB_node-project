pipeline {
    agent any
    tools {
        nodejs 'NodeJS 19.2.0'
    }
    stages {
        stage ("Debugging Output") {
            steps {
                script {
                    sh "echo $BUILD_NUMBER"
                }
            }
        }
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
        stage("Dockerhub Login") {
            steps {
                script {
                    echo "logging in to Dockerhub..."
                    withCredentials([usernamePassword(credentialsId:'Dockerhub', passwordVariable:'DOCKER_PASS', usernameVariable:'DOCKER_USER')]) {
                        sh "echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin"
                    }
                }
            }
        }
        stage("Push Image to Dockerhub"){
            steps {
                echo "pushing image..."
                sh 'docker push opschasingdev/dockerhub:node-app-1.0.0'
            }
        }
    }
}