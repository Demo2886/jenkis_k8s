pipeline {
    agent any

    environment {
    registry = "jokercat2886/test-jenkins"
    registryCredential = 'docker'
    docker_stop = '\$(docker ps -a -q)'
    }
	
    stages {
        stage('YES!!!!!!!!!!!!!!!!!!') {
            steps {
                sh 'kubectl get node'
            }
        }



        stage('Building image') {
          steps{
            script {
              input('Do you want to proceed?')
              dockerImage = docker.build("$registry:$BUILD_NUMBER")
              //dockerImage = docker.build("$registry:latest")
            }
          }
    }		
  }
  
    post {
    success {
      slackSend (color: '#00FF00', message: "Deployment success: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
    }
    failure {
      slackSend (color: '#FF0000', message: "Deployment failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
    }
  }
}
