pipeline{
    agent any
    environment {
        PROJECT_ID = 'essential-city-336316'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'k8s'
    }
    stages{
        stage('Checkout'){
            steps{
                checkout([$class: 'GitSCM', 
                branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[
                    credentialsId: 'c94b22eb-6c7d-440b-b468-06679d537899', 
                    url: 'https://github.com/bala280597/Nodejs.git']]])
            }
        }
        
        stage("Docker Build"){
          steps {
              script {
                  
              if(env.GIT_BRANCH=="main"){
                 
                 sh """ 
                        docker login -u $DOCKER_USER -p $DOCKER_PASS
                        docker build -t bala2805/nodejs:main .
                        docker push bala2805/nodejs:main
                        
                    """ 
              }
             }
          }
        }
        stage("Kubernetes Deployment"){
          steps {
              script {
              if(env.GIT_BRANCH=="main"){
                step([
                    $class: 'KubernetesEngineBuilder',
                    projectId: env.PROJECT_ID,
                    clusterName: env.CLUSTER_NAME,
                    location: env.LOCATION,
                    manifestPattern: 'deploy.yml',
                    credentialsId: env.CREDENTIALS_ID,
                    verifyDeployments: true])
                 
              }
             }
          }
        }
        
    }
}

