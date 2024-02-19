pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/hw-23']],
                          userRemoteConfigs: [[url: 'git@github.com:RiinaVi/dev-ops-course.git',
                                               credentialsId: 'github-credentials']]])
            }
        }

        stage('Node.js configuration') {
            steps {
                dir('hw-23/ansible') {
                     withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                        sh 'ansible-playbook -i inventory.ini node-application-playbook.yml'
                    }
                }
            }
        }
    }
}
