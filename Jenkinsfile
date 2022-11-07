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
 
  
        
    stage("Test Dockerfile with linter") {
      steps {
        script {
          try {
          echo "Linting Dockerfile..."
          sh 'hadolint --ignore DL3018 --ignore DL3013 --ignore DL3019 --ignore DL4003 Dockerfile > lint_report.txt'
          archiveArtifacts artifacts: 'lint_report.txt'
          } catch (Exception err) {
            stagestatus.dockerfile_lint = "Linting failure"
            error "Something wrong with Dockerfile"
          }
        }
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
