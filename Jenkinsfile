pipeline {
    agent any

    environment {
      registry = "jokercat2886/test-jenkins"
      docker_rm = '\$(docker ps -q -f status=exited)'
    
      DOCKER_ID = credentials('DOCKER_ID')
      DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
    
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
            docker.build("${DOCKER_ID}/test-jenkins:latest")
          }
        }
      }

      stage('Test image') {
        steps {
          sh "docker run -p 8001:8000 -d $registry:latest"
	  sleep 5
	  sh "curl http://127.0.0.1:8001"
        }
      }
    
      stage('Push Image to repo') {
        steps {
          script {
	    sh "echo $DOCKER_PASSWORD | docker login -u ${DOCKER_ID} --password-stdin"
            sh "docker push ${DOCKER_ID}/test-jenkins:latest"
            sh "docker ps -q --filter ancestor=jokercat2886/test-jenkins | xargs docker stop"
            sh "docker rm ${docker_rm}"
          }
        }    	
      }
      

    stage('Apply Kubernetes files') {
      steps {
        sh 'kubectl get namespace | grep -q "^pre-prod " || kubectl create namespace pre-prod'
        sh 'kubectl apply -f k8s_bom.yaml --namespace=pre-prod'
        sleep 4
        sh 'kubectl get pods --namespace=pre-prod'
      }
    }
    
    stage('Deploy in prod') {
      steps {
        script {
          catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
            def depl = true
              try{
                input("Deploy in prod?")
              }
              catch(err){
                depl = false
              }
              try{
              if(depl){
                sh 'kubectl get namespace | grep -q "^prod " || kubectl create namespace prod'
                sh 'kubectl apply -f k8s_bom.yaml'
                sleep 4
                sh 'kubectl get pods --namespace=prod'
                sh 'kubectl delete -f k8s_bom.yaml --namespace=pre-prod'
                sh 'kubectl delete namespace pre-prod'
              }
              }
              catch(Exception err){
                error "Deployment filed"
              }
            }
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
