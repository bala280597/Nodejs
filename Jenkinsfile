pipeline{
    agent any
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
                 sh """ docker login -u credentials('docker-user') -p credentials('docker-pass')
                        docker build -t bala2805/nodejs . """
                 
          }
        }
    }
}

