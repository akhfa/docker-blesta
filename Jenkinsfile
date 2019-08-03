pipeline {
    agent {
        docker {
            image 'docker:18.09.5-dind'
            args '-v /.docker:/.docker -v /var/run/docker.sock:/var/run/docker.sock -u root'
            label 'ec2-fleet'
        }
    }
    stages {
        stage('Build') {
            environment {
                DOCKERHUB_CREDS = credentials('dockerhub')
            }
            steps {
                checkout scm
                sh "chmod +x build.sh"
                sh "./build.sh $DOCKERHUB_CREDS_USR $DOCKERHUB_CREDS_PSW akhfa/blesta"
            }
        }
        stage('push') {
            when {
                beforeInput true
                branch 'master'
            }
            input {
                message "Push to registry?"
                id "push-input"
            }
            steps {
                sh "chmod +x push.sh"
                sh "./push.sh $DOCKERHUB_CREDS_USR $DOCKERHUB_CREDS_PSW akhfa/blesta"
            }
        }
    }
}
