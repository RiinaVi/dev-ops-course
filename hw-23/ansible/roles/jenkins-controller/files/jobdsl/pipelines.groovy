// Файл конфігурації пайплайнів
pipelineJob('infrastructure/terraform') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('<Вкажіть git URL>')
                        credentials('my-credentials')
                    }
                    branch('*/master')
                    extensions { }
                }
            }
            scriptPath('<Вкажіть шлях до Jenkinsfile всередині Git>')
            lightweight(true)
        }
    }
}

pipelineJob('ansible/ansible') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('<Вкажіть git URL>')
                        credentials('my-credentials2')
                    }
                    branch('*/master')
                    extensions { }
                }
            }
            scriptPath('<Вкажіть шлях до Jenkinsfile всередині Git>')
            lightweight(true)
        }
    }
}

pipelineJob('application/nodejs') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('<Вкажіть git URL>')
                        credentials('my-credentials3')
                    }
                    branch('*/master')
                    extensions { }
                }
            }
            scriptPath('<Вкажіть шлях до Jenkinsfile всередині Git>')
            lightweight(true)
        }
    }
}
