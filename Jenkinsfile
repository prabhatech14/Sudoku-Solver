pipeline {
    agent any
    stages {
        stage ('Checkout') {
            steps{
                checkout([$class: 'GitSCM', 
                        branches: [[name: '*/master']], 
                        userRemoteConfigs: [[url: 'https://github.com/prabhatech14/Sudoku-Solver']]])
                        //git branch : 'master', url: 'https://github.com/prabhatech14/Sudoku-Solver' 
            }

        }
        stage ('Build and Push Docker Image') {
             environment {
                DOCKER_IMAGE = "prabhatech14/Python_sample:${BUILD_NUMBER}"
                // DOCKERFILE_LOCATION = "https://github.com/prabhatech14/Sudoku-Solver/DockerFile"
                REGISTRY_CREDENTIALS = credentials('docker-cred')
                REGISTRY_CREDENTIALS_PSW = credentials('docker-cred-psw')
            }
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                    def dockerImage = docker.image("${DOCKER_IMAGE}")
                     maskPassword("${env.REGISTRY_CREDENTIALS_USR}:${env.REGISTRY_CREDENTIALS_PSW}") {
                    dockerImage.push()
                   }
                }
            }
        }
        stage ('Update Deployment file') {
            environment {
                GIT_REPO_NAME = "Sudoku-Solver"
                GIT_USER_NAME = "prabhatech14"
            }
            steps {
                withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                        git config user.email "prabhatech14@gmail.com"
                        git config user.name "prabhatech14"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" ./K8s/deployment.yaml
                        git add ./K8s/deployment.yaml
                        git commit -m  "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                    '''
                }
            }
        }
    }
}
