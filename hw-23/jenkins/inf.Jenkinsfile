pipeline {
    agent any

    parameters {
        choice(name: 'STAGE_TO_EXECUTE', choices: ['Apply', 'Destroy'], description: 'Select action')
    }

    stages {
        stage('Checkout') {

            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/hw-23']],
                          userRemoteConfigs: [[url: 'git@github.com:RiinaVi/dev-ops-course.git',
                                               credentialsId: 'github-credentials']]])
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Terraform Apply' }
            }
            steps {
                dir('hw-23/terraform/terraform-modules') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'ec2-key']]) {
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
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'ec2-key']]) {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
