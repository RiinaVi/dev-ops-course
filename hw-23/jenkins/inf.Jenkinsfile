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
                expression { params.STAGE_TO_EXECUTE == 'Apply' }
            }
            steps {
                dir('hw-23/terraform/terraform-modules') {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Destroy' }
            }
            steps {
                dir('application/terraform-app') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                         accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                         credentialsId: '',
                         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                     ]]) {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
