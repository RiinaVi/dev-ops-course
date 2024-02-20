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
                    withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                        script {
                            sh "ssh -o StrictHostKeyChecking=no ${USER}@${REMOTE_HOST} 'mkdir -p ${DEST_FOLDER}'"
                            sh "scp -o StrictHostKeyChecking=no -r app/build/ app/package.json ${USER}@${REMOTE_HOST}:${DEST_FOLDER}"
                            sh "ssh -o StrictHostKeyChecking=no ${USER}@${REMOTE_HOST} 'cd ${DEST_FOLDER} && npm install && sudo npm install forever -g && forever start build/index.js'"
                        }
                    }
                }
            }
        }
    }
}
