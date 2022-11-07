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
 
  
        
	     stage('Test Dockerfile hadolint') {
	       steps {
            sh "docker run --rm -i hadolint/hadolint hadolint --ignore DL3013  --ignore DL3042  < ~/musor/jenkis_k8s/Dockerfile"
            }
         }


        stage('Building image') {
          steps{
            script {
              //input('Do you want to proceed?')
              //dockerImage = docker.build("$registry:$BUILD_NUMBER")
              docker.build("$registry:latest")
            }
          }
    }		
  }
  
    post {
    success {
      slackSend (color: '#00FF00', message:"Build failed  - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)")
    }
    failure {
      slackSend (color: '#FF0000', failOnError:true, message:"Build failed  - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)")
    }
  }
}
