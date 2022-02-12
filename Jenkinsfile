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
        
        stage(env.GIT_BRANCH+"Build"){
          steps {
                 echo 'Pulling... ' + env.GIT_BRANCH
                 
          }
        }
    }
}

