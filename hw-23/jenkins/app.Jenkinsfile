pipeline {
    agent any

    parameters {
            string(name: 'USER', defaultValue: 'ubuntu',  description: 'Username')
            string(name: 'SERVER_IP', defaultValue: '',  description: 'Server IP address')
            string(name: 'DESTINATION_PATH', defaultValue: '/home/ubuntu/app',  description: 'Server destination path')
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

        stage('Build') {
            steps {
                dir('hw-23/app') {
                    script {
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'hw-23/app/build/'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: "ec2-key", keyFileVariable: 'keyfile')]) {
                        script {
                            sh "scp -i ${keyfile} -r hw-23/app/build/ hw-23/app/package.json ${USER}@${SERVER_IP}:/"
                            sh "ssh -i ${keyfile} ${USER}@${SERVER_IP} 'npm install && sudo npm install forever -g && forever start build/index.js'"
                        }
                    }
                }
            }
        }
    }
}
