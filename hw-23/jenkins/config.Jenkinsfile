pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'hw-23', description: 'Git branch to checkout')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/$BRANCH_NAME']],
                          userRemoteConfigs: [[url: 'git@github.com:RiinaVi/dev-ops-course.git',
                                               credentialsId: 'github-credentials']]])
            }
        }

        stage('Node.js configuration') {
            steps {
                dir('hw-23/ansible') {
                    sshagent(credentials: ['ec2-key']) {
                        sh 'ansible-playbook -i inventory.ini node-application-playbook.yml'
                    }
                }
            }
        }
    }
}
