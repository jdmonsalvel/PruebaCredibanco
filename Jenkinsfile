pipeline {
    agent any

    stages {
        stage('Clonar Repositorio') {
            steps {
                checkout scm
            }
        }

        stage('Pruebas Unitarias') {
            steps {
                script {
                    sh 'apt-get update'
                    sh 'apt-get install -y python3'
                    sh 'curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py'
                    sh 'python3 get-pip.py'
                    sh 'pip install -r requirements.txt'
                    sh 'pytest'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube') {
                        sh 'sonar-scanner'
                    }
                }
            }
        }

        stage('Construir y Subir a Docker Hub') {
            steps {
                script {
                    sh 'docker build -t mi-aplicacion-web:${BUILD_NUMBER} .'
                    sh 'docker tag mi-aplicacion-web:${BUILD_NUMBER} tu_usuario_docker_hub/mi-aplicacion-web:${BUILD_NUMBER}'
                    sh 'docker login -u jdmonsalvel -p T3mp0ral01.'
                    sh 'docker push tu_usuario_docker_hub/mi-aplicacion-web:${BUILD_NUMBER}'
                }
            }
        }
    }
}
