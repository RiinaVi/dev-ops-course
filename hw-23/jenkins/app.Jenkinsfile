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
                withCredentials([sshUserPrivateKey(credentialsId: "ec2-key", keyFileVariable: 'keyfile')]) {
                 sh "ssh-keyscan -t rsa ${SERVER_IP} >> ~/.ssh/known_hosts"
                 sh "scp -i ${keyfile} -r ./build ${USER}@${SERVER_IP}:./build"
                 sh "scp -i ${keyfile} -r ./package.json ${USER}@${SERVER_IP}:./package.json"
                 sh "ssh -i ${keyfile} ${USER}@${SERVER_IP} 'npm install && sudo npm install forever -g && forever start build/index.js'"
                }
            }
        }
    }
}
