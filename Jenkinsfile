pipeline {
    agent any

    environment{
        img = ""
        registry = "stivenvr/goapp"
        dockerImage = ""
    }

    stages {
        stage('Unit testing'){
            steps{
                sh "go test"
            }
        }
        stage('Build image'){
            when {
                branch 'main'
            }
            steps{
                script{
                    img = registry //+ ":${env.BUILD_ID}"
                    dockerImage = docker.build("${img}")
                }
                
            }
        }
        stage('Uploadiong to DockerHub'){
            steps{
                script{
                    if (env.BRANCH_NAME =='develop'){
                        // steps{

                            sh "echo Pushing"
                            
                        // }
                    }
                }
            }
        }
        stage('Deploy in server'){
            steps{

                sh "echo Deploying"
                
            }
        }

    }
}
