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
                    sh 'echo "PATH: $PATH"'
                    sh 'echo "Python Version: $(python --version)"'
                    sh 'echo "pip Version: $(pip --version)"'
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
