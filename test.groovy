pipeline {
    agent any
    stages {
        stage("Build"){
            steps{
                echo "Build Successfully"
            }
        }
         stage("Test"){
            steps{
                echo "Test Successfully"
            }
        }
         stage("deploy"){
            steps{
                echo "deploy Successfully"
            }
        }
    }
    post{
        always{
            echo "Implemented code"
        }
        success{
            echo "Code Successfully implemented"
        }
        failure{
            echo "Failed test"
        }
    }
}
