pipeline {
    agent any
    stages {
        stage('Unit testing'){
            when{
                branch 'main'
            }
            steps{
                sh "go test"
            }
        }
        stage('Build image'){
            steps{
                sh "echo Building"
                
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
