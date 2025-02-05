pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=zakir", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop zakir"
                    sh "docker rm zakir"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/webproj/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app zakeer910/project2'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Zakeer@7786" | docker login -u "zakeer910" --password-stdin'
                sh 'docker push zakeer910/project2'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull zakeer910/project2
'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name zakir -p 8081:8080 zakeer910/project2
'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f zakir'
        }
        always{
            echo 'Deployed'
        }
    }

}