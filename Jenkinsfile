pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'eniiwinner'
        IMAGE_NAME = 'java-calculator-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the image with proper variable interpolation
                    def imageName = "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    docker.build(imageName)
                }
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                script {
                    sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    def imageName = "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    def latestTag = "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                    
                    sh "docker push ${imageName}"
                    sh "docker tag ${imageName} ${latestTag}"
                    sh "docker push ${latestTag}"
                }
            }
        }
        
        stage('Clean up') {
            steps {
                script {
                    def imageName = "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    def latestTag = "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                    
                    sh "docker rmi ${imageName}"
                    sh "docker rmi ${latestTag}"
                }
            }
        }
    }
    
    post {
        always {
            sh 'docker logout'
        }
    }
}
