pipeline {
    agent any

    parameters {
        string(name: 'SERVER_IP',  description: 'Server IP address')
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

        stage('Node.js configuration') {
            steps {
                dir('hw-23/ansible') {
                     withAWS(credentials: 'aws-credentials') {
                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-key')]) {
                            sh 'ansible-playbook -i inventory.ini node-application-playbook.yml --extra-vars "server_ip=$SERVER_IP"'
                        }
                    }
                }
            }
        }

        stage('Trigger Application Pipeline') {

            steps {
                build job: 'application/nodejs', parameters: [
                    string(name: 'SERVER_IP', value: '$SERVER_IP')
                ]
            }
        }
    }
}
