pipeline {
    agent any
    
    environment {
        DOCKER_HUB = credentials('docker-hub-credentials')
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(“eniiwinner/java-web-calculator:${env.BUILD_NUMBER}")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image(“eniiwinner/java-web-calculator:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8080:8080 eniiwinner/java-web-calculator:${env.BUILD_NUMBER}'
            }
        }
    }
}
