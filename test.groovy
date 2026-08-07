pipeline {
    agent none
    stages {
        
        stage("Stage 1"){
            agent{
                    label 'ubun'
                }
            environment{
            User_Name="Ramya"
            role="dev"
        }
            steps{
                echo "Admin Name : ${env.User_Name}"
                echo "Role : ${env.role}"
                }
                
        }
       
        stage ("Stage 2"){
            agent{
                    label 'built'
                }
            steps{
                 sh "date"
                 sh "uptime"
                 sh "pwd"
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
