pipeline {
    agent { label 'wsl-agent' }  // ensures this job runs on your WSL node
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

  post {
    success {
      echo "✅ Terraform deployment successful!"
    }
    failure {
      echo "❌ Terraform deployment failed!"
    }
  }
}

