pipeline {
    agent any

    stages {
        if (env.BRANCH_NAME =='main'){
            stage('Build image'){
                steps{
                    sh "echo Building"
                    // script{
                    //     img = registry //+ ":${env.BUILD_ID}"
                    //     dockerImage = docker.build("${img}")
                    // }
                }
            }
        }
        if (env.BRANCH_NAME =='develop'){
            stage('Uploadiong to DockerHub'){
                steps{

                    sh "echo Pushing"
                    // script{
                    //     docker.withRegistry('https://registry.hub.docker.com', registryCredential){
                    //         dockerImage.push()
                    //     }
                        
                    // }
                }
            }
            stage('Deploy in server'){
                steps{

                    sh "echo Deploying"
                    // script{
                    //     def stopcontainer = "docker stop ${JOB_NAME}"
                    //     def delcontainer = "docker rm ${JOB_NAME}"
                    //     def delimages = "docker image prune -a --force"
                    //     def drun = "docker run -d --name ${JOB_NAME} -p 9000:9000 ${img}"
                        
                    //     sshagent(credentials: [sshCredential]){
                    //         sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no stiven@192.168.101.70 ${stopcontainer}"
                    //         sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no stiven@192.168.101.70 ${delcontainer}"
                    //         sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no stiven@192.168.101.70 ${delimages}"
                    //         sh "ssh -o StrictHostKeyChecking=no stiven@192.168.101.70 ${drun}"
                    //     }
                    // }
                }
            }
        }
    }
}
