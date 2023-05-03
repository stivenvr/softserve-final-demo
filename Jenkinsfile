pipeline {
    agent any

    environment{
        job = "finaldemo"
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
        stage('Go run test'){
            when {
                branch 'develop'
            }
            steps{
                sh "go build -v -o ./app ./main.go ./algorithm.go"
                sh "./app"
            }
        }
        stage('Build image'){
            when {
                branch 'main'
            }
            steps{
                script{
                    img = registry //+ ":${env.BUILD_ID}"
                    sh returnStatus: true, script: "docker stop ${job}"
                    sh returnStatus: true, script: "docker rm ${job}"
                    sh returnStatus: true, script: "docker image prune -a --force"
                    dockerImage = docker.build("${img}")
                }
                
            }
        }
        stage('Running docker'){
            when{
                branch 'main'
            }
            steps{
                sh "docker run -d --name ${job} -p 7777:5555 ${img}"
            }
        }
        stage('Uploadiong to DockerHub'){
            when {
                branch 'main'
            }
            steps{
                sh "echo Pushing"
            }
        }
        stage('Deploy in server'){
            when {
                branch 'main'
            }
            steps{

                sh "echo Deploying!"
                
            }
        }

    }
}
