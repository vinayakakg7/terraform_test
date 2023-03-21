pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/vinayakakg7/terraform_test.git'
      }
    }

    stage('Terraform Init') {
      steps {
        bat 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        bat 'terraform plan'
      }
    }

    stage('Terraform Apply') {
      steps {
        bat 'terraform apply --auto-approve'
      }
    }
  }
}
