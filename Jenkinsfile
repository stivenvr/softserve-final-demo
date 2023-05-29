pipeline {
    agent {label 'ec2-slave'}

    environment{
        job = "finaldemo"
        img = ""
        registry = "stivenvr/goapp"
        dockerImage = ""
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        // EC2_SSH_KEY = credentials('EC2_SSH_KEY')
    }

    stages {
        stage('Unit testing'){
            steps{
                sh "go test"
            }
        }
        stage('SonarQube analysis') {
            steps{
                script{
                    def scannerHome = tool 'sonarscanner';
                    withSonarQubeEnv('sonarcloud') { // If you have configured more than one global server connection, you can specify its name
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
        stage("Quality Gate"){
            steps{
                script{
                    timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
                        def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
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
        stage('Docker login'){
            when {
                branch 'main'
            }
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
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
                    sh "pwd"
                    // sshagent(credentials:[EC2_SSH_KEY]){
                    // sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@ec2-44-192-105-203.compute-1.amazonaws.com ${stopcontainer}"
                    // sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@ec2-44-192-105-203.compute-1.amazonaws.com ${delcontainer}"
                    // sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@ec2-44-192-105-203.compute-1.amazonaws.com ${delimages}"
                    // sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@ec2-44-192-105-203.compute-1.amazonaws.com ${drun}"
                    // }
                }
            }
        }   
    }
    // post {
    //     always {
    //         sh "docker logout"
    //     }
    // }
}
