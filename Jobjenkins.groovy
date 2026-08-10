pipeline {
    agent any 

    stages {
        stage('checkout'){
            steps{
                git "https://github.com/Ramya20041110/DemoRepo01/blob/master/Health-Monitor.sh"

            }
        }
        stage('Runmonitor'){
            steps{
                sh 'chmod +x Health-Monitor.sh'
                sh './Health-Monitor.sh'
            }
        }
    }
}
