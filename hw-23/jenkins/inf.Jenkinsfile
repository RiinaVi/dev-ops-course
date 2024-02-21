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
                dir('hw-23/terraform-app/terraform-modules') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                         accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                         credentialsId: '',
                         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                     ]]) {
                        sh 'terraform init'
                        sh 'terraform workspace select app || terraform workspace new app'
                        sh 'terraform apply -auto-approve -lock=false'
                    }
                }
            }
        }

        stage('Trigger Ansible Pipeline') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Apply' }
            }

            steps {
                dir('hw-23/terraform-app/terraform-modules') {
                   withCredentials([[
                       $class: 'AmazonWebServicesCredentialsBinding',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        credentialsId: '',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                   ]]) {
                        build job: 'ansible/ansible', parameters: [
                            string(name: 'SERVER_IP', value: sh(returnStdout: true, script: "terraform output server_ip"))
                        ]
                    }
                }


            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.STAGE_TO_EXECUTE == 'Destroy' }
            }
            steps {
                dir('hw-23/terraform-app/terraform-modules') {
                     withCredentials([[
                         $class: 'AmazonWebServicesCredentialsBinding',
                          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                          credentialsId: '',
                          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                     ]]) {
                        sh 'terraform destroy -auto-approve -lock=false'
                    }
                }
            }
        }
    }
}
