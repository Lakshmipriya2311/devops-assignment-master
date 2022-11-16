pipeline {
      environment {
        imagename = "151260271154.dkr.ecr.eu-central-1.amazonaws.com/devops-test"
      }
     agent any
     stages { 
     stage('Building image') {
      steps{
        script {
          sh "docker build -t $imagename:$BUILD_NUMBER ."
        }
      }
     }
     stage('Deploy Image') {
      steps{
        script {
          sh "aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 151260271154.dkr.ecr.eu-central-1.amazonaws.com"
          sh "docker push $imagename:$BUILD_NUMBER"
         }
       }
     }
    stage('Remove Unused docker image') {
      steps{
         sh "docker rmi $imagename:$BUILD_NUMBER"

      }
    }
    stage('Deploy k8s') {
      steps{
         sh "sed -i 's|VERSION|$BUILD_NUMBER|g' deploy.yaml"
         sh "kubectl apply -f deploy.yaml"
         sh "kubectl apply -f service.yaml"

      }
    }
  }
}
