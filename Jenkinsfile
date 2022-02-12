pipeline{
    agent any
    environment {
        DOCKER_USER = credentials("docker-user")
        DOCKER_PASS = credentials("docker-pass")
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
                  kubernetesDeploy configs: 'deploy.yml', 
                      kubeConfig: [path: ''], 
                      kubeconfigId: 'k8s', 
                      secretName: '', 
                      ssh: [sshCredentialsId: '*', sshServer: ''], 
                      textCredentials: [certificateAuthorityData: '', 
                      clientCertificateData: '', 
                      clientKeyData: '', serverUrl: 'https://']
                 
              }
             }
          }
        }
        
    }
}

