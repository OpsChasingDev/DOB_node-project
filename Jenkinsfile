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
        stage ("Define version increment") {
            steps {
                script {
                    dir("app") {
                        sh 'npm version minor'
                        def packageJson = readJSON file: 'package.json'
                        def version = packageJson.version
                        sh "echo $version"
                        env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                        sh "echo ${IMAGE_NAME}"
                    }
                }
            }
        }
        stage("Test App") {
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
        stage("Build App Image") {
            steps {
                script {
                    echo "building app docker image..."
                    sh 'docker build -t opschasingdev/dockerhub:node-app-${IMAGE_NAME} .'
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
        stage("Push Image to Dockerhub") {
            steps {
                echo "pushing image..."
                sh 'docker push opschasingdev/dockerhub:node-app-${IMAGE_NAME}'
            }
        }
        stage("Github Login") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'GitHub_PAT', passwordVariable:'GITHUB_PAT_PASS', usernameVariable:'GITHUB_PAT_USER')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins-3.droplet"'
                        sh "git remote set-url origin https://${GITHUB_PAT_USER}:${GITHUB_PAT_PASS}@github.com/OpsChasingDev/DOB_node-project.git"
                    }
                }
            }
        }
        stage("Commit to Git") {
            steps {
                script {
                    sh 'git add .'
                    sh 'git commit -m "increment app version"'
                    sh 'git push origin HEAD:jenkinsfile'
                }
            }
        }
    }
}