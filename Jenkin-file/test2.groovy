pipeline {

    agent {
        label 'ubun'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Ramya20041110/DemoRepo01'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                sudo cp hostpage.html /var/www/html/
                '''
            }
        }
    }
}
