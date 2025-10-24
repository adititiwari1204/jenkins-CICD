pipeline {
  agent any

  environment {
    // Update these values for your environment
    REGISTRY = "your-registry.example.com"        // e.g. registry.hub.docker.com or my-registry:5000
    IMAGE    = "my-nginx"                         // image name in the registry
    TAG      = "${env.BUILD_NUMBER}"              // you can change to use git commit hash
    CREDENTIALS_ID = "docker-credentials-id"      // Jenkins credentials id for docker registry
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build image') {
      steps {
        script {
          // Uses Jenkins Docker Pipeline plugin's docker.build
          dockerImage = docker.build("${REGISTRY}/${IMAGE}:${TAG}")
        }
      }
    }

    stage('Run smoke test (optional)') {
      steps {
        script {
          // Run a temporary container to smoke-test the image (optional)
          def cid = dockerImage.run("-d -p 8080:80")
          // wait a bit for container to start
          sleep 5
          sh "curl -f http://localhost:8080/ || (docker logs ${cid.id} && exit 1)"
          // stop and remove
          sh "docker rm -f ${cid.id} || true"
        }
      }
    }

    stage('Push') {
      steps {
        script {
          docker.withRegistry("https://${REGISTRY}", CREDENTIALS_ID) {
            dockerImage.push()
            // push latest tag too (optional)
            dockerImage.push("latest")
          }
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}
