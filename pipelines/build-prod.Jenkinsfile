pipeline {
    agent any

    triggers {
        githubPush()
    }

    options {
        timeout(time: 10, unit: 'MINUTES')  // discard the build after 10 minutes of running
        timestamps()  // display timestamp in console output
    }

    environment {
        IMAGE_TAG = "v1.0.$BUILD_NUMBER"
        IMAGE_BASE_NAME = "netflix-movie-catalog-prod"

        DOCKER_CREDS = credentials('3b05bd85-f609-437c-88d3-e436599b4ac9')
        DOCKER_USERNAME = "${DOCKER_CREDS_USR}"  // The _USR suffix added to access the username value
        DOCKER_PASS = "${DOCKER_CREDS_PSW}"      // The _PSW suffix added to access the password value
    }

    stages {
        stage('Docker login') {
            steps {
                sh '''
                  docker login -u $DOCKER_USERNAME -p $DOCKER_PASS
                '''
            }
        }

        stage('Build and push image') {
            steps {
                sh '''
                    IMAGE_FULL_NAME=$DOCKER_USERNAME/$IMAGE_BASE_NAME:$IMAGE_TAG
                    docker build -t $IMAGE_FULL_NAME .
                    docker push $IMAGE_FULL_NAME
                '''
            }
        }
        stage('Trigger Deploy') {
            steps {
                build job: 'NetflixDeployProd', wait: false, parameters: [
                    string(name: 'SERVICE_NAME', value: "NetflixMovieCatalog"),
                    string(name: 'IMAGE_FULL_NAME_PARAM', value: "$DOCKER_USERNAME/$IMAGE_BASE_NAME:$IMAGE_TAG")
                ]
            }
        }
    }
}