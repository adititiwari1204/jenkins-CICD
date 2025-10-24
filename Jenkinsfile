pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Fetching code from GitHub...'
                git url:'https://github.com/adititiwari1204/jenkins-CICD.git',branch:'main'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                docker build -t nginx . // Example: for Node.js
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
               sh' docker run -d --name nginx-test -p 8080:80 nginx'
                    sleep 5
                   sh' curl -I http://localhost:8080'
                    docker stop nginx-test
                    docker rm nginx-test   // Replace this with your own test command
                sh 'npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
               sh' docker stop nginx-prod' || true
               sh'docker rm nginx-prod' || true
               sh' docker run -d --name nginx-prod -p 80:80 nginx'  // Example placeholder (you can change this to Docker, server, etc.)
                sh 'echo "Deploy successful!"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}

 
      
      
