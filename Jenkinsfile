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
                 echo 'Pulling... ' + env.GIT_BRANCH
                 sh """ 
                        echo env.DOCKER_USER
                        docker login -u env.DOCKER_USER -p env.DOCKER_PASS
                        docker build -t bala2805/nodejs .
                        docker push bala2805/nodejs:env.GIT_BRANCH
                        
                    """
                 
          }
        }
    }
}

