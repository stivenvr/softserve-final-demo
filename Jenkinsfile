pipeline {
    agent any

    environment{
        job = "finaldemo"
        img = ""
        registry = "stivenvr/goapp"
        dockerImage = ""
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        EC2_CREDENTIALS = credentials('ec2')
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
        stage('Docker login'){
            when {
                branch 'main'
            }
            steps{
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
            }
        }
        stage('Push to dockerhub'){
            when {
                branch 'main'
            }
            steps{
                sh "docker push ${registry}"
            }
        }
        stage('Deploy in server'){
            when {
                branch 'main'
            }
            steps{
                script{
                    def stopcontainer = "docker stop ${job}"
                    def delcontainer = "docker rm ${job}"
                    def delimages = "docker image prune -a --force"
                    def drun = "docker run -d --name ${job} -p 7777:5555 ${img}"
                    // sshagent(credentials:[EC2_CREDENTIALS]){
                    sh returnStatus: true, script: "ssh -i ${EC2_CREDENTIALS_PK} ubuntu@ec2-3-144-14-115.us-east-2.compute.amazonaws.com ${stopcontainer}"
                    sh returnStatus: true, script: "ssh -i ${EC2_CREDENTIALS_PK} ubuntu@ec2-3-144-14-115.us-east-2.compute.amazonaws.com ${delcontainer}"
                    sh returnStatus: true, script: "ssh -i ${EC2_CREDENTIALS_PK} ubuntu@ec2-3-144-14-115.us-east-2.compute.amazonaws.com ${delimages}"
                    sh returnStatus: true, script: "ssh -i ${EC2_CREDENTIALS_PK} ubuntu@ec2-3-144-14-115.us-east-2.compute.amazonaws.com ${drun}"
                    // }
                }
            }
        }   
    }
    post {
        always {
            sh "docker logout"
        }
    }
}
