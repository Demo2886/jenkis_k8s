pipeline {
    agent any

    environment {
    registry = "jokercat2886/test-jenkins"
    registryCredential = 'docker'
    docker_rm = '\$(docker ps -q -f status=exited)'
    }
	
    stages {

 
      stage('Test Dockerfile hadolint') {
              steps{
            sh "docker run --rm -i hadolint/hadolint < Dockerfile"
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
    
        stage('Test image') {
        steps {
              sh "docker run -p 8001:8000 -d $registry:latest"
	          //sh "docker run -p 8002:8003 -d $registry:$BUILD_NUMBER"
	          sh "curl http://127.0.0.1:8001"
                  sh "docker ps -q --filter ancestor=jokercat2886/test-jenkins | xargs docker stop"
                  sh "docker rm $docker_rm"
        }
    }
    
     stage('Push Image to repo') {
            script {
                docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    docker.push("${env.BUILD_NUMBER}")
                    docker.push("latest")
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
