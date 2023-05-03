pipeline {
    agent any

    environment{
        img = ""
        registry = "stivenvr/goapp"
        dockerImage = ""
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        stage('Unit testing'){
            steps{
                sh "go test"
            }
        }
        /* stage('Go run test'){
            when {
                branch 'develop'
            }
            steps{
                sh "go build -v -o ./app ./main.go ./algorithm.go"
                sh "./app"
            }
        } */
        stage('Build image'){
            when {
                branch 'main'
            }
            steps{
                script{
                    img = registry //+ ":${env.BUILD_ID}"
                    sh returnStatus: true, script: "docker stop ${JOB_NAME}"
                    sh returnStatus: true, script: "docker rm ${JOB_NAME}"
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
                sh "docker run -d --name ${JOB_NAME} -p 7777:5555 ${img}"
            }
        }
        stage('Docker login'){
            when {
                branch 'main'
            }
            steps{
                sh "sh echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
            }
        }
        stage('Uploadiong to dockerhub'){
            when {
                branch 'main'
            }
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential){
                }
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
