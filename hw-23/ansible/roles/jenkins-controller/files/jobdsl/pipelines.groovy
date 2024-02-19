// Файл конфігурації пайплайнів
pipelineJob('infrastructure/terraform') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('git@github.com:RiinaVi/dev-ops-course.git')
                        credentials('github-credentials')
                    }
                    branch('*/hw-23')
                    extensions { }
                }
            }
            scriptPath('hw-23/jenkins/inf.Jenkinsfile')
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
                        url('git@github.com:RiinaVi/dev-ops-course.git')
                        credentials('github-credentials')
                    }
                    branch('*/hw-23')
                    extensions { }
                }
            }
            scriptPath('hw-23/jenkins/config.Jenkinsfile')
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
                        url('git@github.com:RiinaVi/dev-ops-course.git')
                        credentials('github-credentials')
                    }
                    branch('*/hw-23')
                    extensions { }
                }
            }
            scriptPath('hw-23/jenkins/app.Jenkinsfile')
            lightweight(true)
        }
    }
}
