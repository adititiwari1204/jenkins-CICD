pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  
        IMAGE_NAME = "tejaswinism/nginx-app"  
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image for Nginx...'
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo 'Pushing Nginx image to DockerHub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $IMAGE_NAME:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Nginx container...'
                // Remove old container if exists
                sh 'docker rm -f nginx-app || true'
                // Run new container
                sh 'docker run -d -p 9090:80 --name nginx-app $IMAGE_NAME:latest'
            }
        }
    }

    post {
        success {
            echo 'Nginx deployment successful!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
