pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'hw-23', description: 'Git branch to checkout')
        choice(name: 'STAGE_TO_EXECUTE', choices: ['Checkout', 'Terraform Apply', 'Terraform Destroy'], description: 'Select stage to execute')
    }

    stages {
        stage('Checkout') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Checkout' }
            }
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/$BRANCH_NAME']],
                          userRemoteConfigs: [[url: 'https://github.com/RiinaVi/dev-ops-course.git',
                                               credentialsId: 'git-credentials']]])
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Terraform Apply' }
            }
            steps {
                dir('application/terraform-app') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Terraform Destroy' }
            }
            steps {
                dir('application/terraform-app') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
