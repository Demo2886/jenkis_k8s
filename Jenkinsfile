pipeline {
    agent any

    environment {
    registry = "jokercat2886/test-jenkins"
    registryCredential = 'docker'
    docker_stop = '\$(docker ps -a -q)'
    }
	
    stages {
        stage('Hello') {
            steps {
                sh 'kubectl get node'
            }
        }

        stage('Building image') {
          steps{
            script {
              dockerImage = docker.build("$registry:$BUILD_NUMBER")
              dockerImage = docker.build("$registry:latest")
            }
          }
    }		
  }
}
