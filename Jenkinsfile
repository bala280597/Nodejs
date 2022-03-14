pipeline{
    agent any
    environment {
        PROJECT_ID = 'refined-circuit-342805'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'refined-circuit-342805'
        DOCKER_USER = credentials('docker-user')
        DOCKER_PASS = credentials('docker-pass')
        USER_CREDENTIALS = credentials('jenkins_password')
    }
    stages{
        
        stage("Docker Build"){
          steps {
              script {
              if( (env.GIT_BRANCH.contains("test")) || (env.GIT_BRANCH.contains("develop")) || (env.GIT_BRANCH == "main") ) {
                  sh """ docker login -u $DOCKER_USER -p $DOCKER_PASS """
              if(env.GIT_BRANCH=="main"){
                 sh """
                        docker build -t bala2805/nodejs:main-${env.BUILD_ID} .
                        docker push bala2805/nodejs:main-${env.BUILD_ID}
                    """
              }
              if(env.GIT_BRANCH.contains("develop")){
                 sh """
                        docker build -t bala2805/nodejs:dev-${env.BUILD_ID} .
                        docker push bala2805/nodejs:dev-${env.BUILD_ID}
                    """
              }
              if(env.GIT_BRANCH.contains("test")) {
                 sh """
                        docker build -t bala2805/nodejs:test-${env.BUILD_ID} .
                        docker push bala2805/nodejs:test-${env.BUILD_ID}
                    """
               }
              }
             }
          }
        }
        
        
        stage("Kubernetes Deployment"){
          steps {
              script {
              if( (env.GIT_BRANCH.contains("test")) || (env.GIT_BRANCH.contains("develop")) || (env.GIT_BRANCH == "main") ) {
                  sh """ docker login -u $DOCKER_USER -p $DOCKER_PASS """
              if(env.GIT_BRANCH=="main"){
                   sh """
                        export IMAGE_NAME=bala2805/nodejs:main-${env.BUILD_ID}
                        export NAMESPACE=${env.GIT_BRANCH}
                        cat deploy.yml | envsubst > deployment.yml
                    """
                 }
               if(env.GIT_BRANCH.contains("develop")){
                   sh """
                        docker pull bala2805/nodejs:dev-${env.BUILD_ID}
                        export IMAGE_NAME=bala2805/nodejs:dev-${env.BUILD_ID}
                        export NAMESPACE=${env.GIT_BRANCH}
                        cat deploy.yml | envsubst > deployment.yml
                    """
                 }
                 if(env.GIT_BRANCH.contains("test")){
                   sh """
                        docker pull bala2805/nodejs:test-${env.BUILD_ID}
                        export IMAGE_NAME=bala2805/nodejs:test-${env.BUILD_ID}
                        export NAMESPACE=${env.GIT_BRANCH}
                        cat deploy.yml | envsubst > deployment.yml
                    """
                 }
                step([
                    $class: 'KubernetesEngineBuilder',
                    projectId: env.PROJECT_ID,
                    clusterName: env.CLUSTER_NAME,
                    location: env.LOCATION,
                    manifestPattern: 'deployment.yml',
                    credentialsId: env.CREDENTIALS_ID,
                    verifyDeployments: false])
                }
             }
          }
        }    
    }
     post { 
        always { 
            sh """ python Build.py ${USER_CREDENTIALS} bala2805/Nodejs ${JOB_NAME} ${BUILD_NUMBER} ${currentBuild.durationString.replace(' and counting', '')} """
        }
    }
}
