pipeline {
    agent none
    parameters {
        string(name:'employee', defaultValue:'Ramya')
        choice(name:'ops', choices:['Dev','QA','tester'])
        booleanParam(name:'deploy', defaultValue:true)
    }
    stages {
        
        stage("Stage 1"){
            agent{
                    label 'ubun'
                }
            environment{
            App_name="fruit"
            Version01 ="1.0"
        }
            steps{
                echo "Application Name : ${env.App_name}"
                echo "Version : ${env.Version01}"
                }
                
        }
        stage ("Stage 2"){
            agent{
                    label 'ubun'
                }

            steps{
                catchError(message: 'error occur still runs for processing other stage',buildResult: 'SUCCESS',stageResult: 'FAILURE') {
                    sh "jjj"  
                    
                }
                 
            }
                
        }
      
        stage ("Stage 3"){
            agent{
                    label 'built'
                }
            steps{
                 sh "uptime"
                 echo "employee of the parameter ${params.employee}"
                 echo "ops of the parameter ${params.ops}"
            }
                
        }
        stage ("Stage 4"){
            agent{
                    label 'ubun'
                }
            steps{
                 sh "date"
                 echo "ops of the parameter ${params.deploy}"
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
