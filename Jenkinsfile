pipeline {
    agent any
    environment {
        CREDS = credentials('dockerhub')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'DOCKER_BUILDKIT=1 docker build -f Dockerfile-pipeline -t ybudic/todo-fe:latest --target builder .'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'DOCKER_BUILDKIT=1 docker build -f Dockerfile-pipeline -t ybudic/todo-fe:latest --target testing .'
            }
        }
        stage('Delivery') {
            steps {
                echo 'Delivery....'
                sh 'DOCKER_BUILDKIT=1 docker build -f Dockerfile-pipeline -t ybudic/todo-fe:${BUILD_NUMBER} --target delivery .'
            }
        }
         stage('Cleanup') {
            steps {
                echo 'Cleanup....'
                sh 'docker system prune -f'
            }
        }
         stage('Push') {
            steps {
                echo 'pushing to dockerhub....'
                sh 'docker login -u ${CREDS_USR} -p ${CREDS_PSW}'
                sh 'docker tag ${BUILD_NUMBER} ybudic/todo-fe:latest'
                sh 'docker push ybudic/todo-fe:${BUILD_NUMBER}'
            }
        }
    }
}