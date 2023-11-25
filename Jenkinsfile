pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'python:3.9'
        SONARQUBE_URL = 'http://172.25.208.249:8001/'
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                checkout scm
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Pruebas Unitarias') {
            steps {
                script {
                    sh 'docker run ${DOCKER_IMAGE}:${BUILD_NUMBER} pytest'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube') {
                        sh "docker run -e SONAR_HOST_URL=${SONARQUBE_URL} ${DOCKER_IMAGE}:${BUILD_NUMBER} sonar-scanner"
                    }
                }
            }
        }

        stage('Limpiar') {
            steps {
                script {
                    sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }
    }
}
