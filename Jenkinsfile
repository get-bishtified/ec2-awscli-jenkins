pipeline {
  agent any

  options {
    timestamps()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Verify IAM Role') {
      steps {
        sh '''
          echo "Verifying IAM Role access..."
          aws sts get-caller-identity
        '''
      }
    }

    stage('Provision EC2') {
      steps {
        sh '''
          chmod +x scripts/create-ec2.sh
          ./scripts/create-ec2.sh
        '''
      }
    }
  }

  post {
    success {
      echo 'EC2 provisioning completed successfully.'
    }
    failure {
      echo 'EC2 provisioning failed.'
    }
  }
}

