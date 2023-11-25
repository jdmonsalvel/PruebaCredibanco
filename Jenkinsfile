pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            label 'docker-pip-agent'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        REPO_NAME = sh(script: 'basename $PWD', returnStdout: true).trim()
        DOCKER_IMAGE_NAME = "${REPO_NAME}:${BUILD_NUMBER}"
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials-id'
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS, usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                    }
                    sh "docker tag ${DOCKER_IMAGE_NAME} jdmonsalvel/${DOCKER_IMAGE_NAME}"
                    sh "docker push jdmonsalvel/${DOCKER_IMAGE_NAME}"
                }
            }
        }

        stage('Run SonarQube') {
            steps {
                script {
                    withEnv(["PATH+MAVEN=${tool 'Maven'}/bin"]) {
                        sh "mvn sonar:sonar -Dsonar.host.url=http://172.25.208.249:8001/ -Dsonar.login=<SONAR_TOKEN>"
                    }
                }
            }
        }

        stage('Install and Run Pytest') {
            steps {
                script {
                    sh 'pip install pytest'
                    sh 'pytest'
                }
            }
        }
    }
}
