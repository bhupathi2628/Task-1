@NonCPS
def notifyBuildStatus(String buildStatus = 'STARTED') {
    buildStatus =  buildStatus ?: 'SUCCESSFUL'
    def SCMCause = currentBuild.rawBuild.getCause(hudson.triggers.SCMTrigger$SCMTriggerCause)
    def UserCause = currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause)
    if (SCMCause) {
        TRIGGER = "${SCMCause.getShortDescription()}"
    } else if (UserCause) {
        TRIGGER = "${UserCause.getShortDescription()}"
    }
    // Default values 
    def colorCode = 'danger'
    //def subject = "*${ENVIRONMENT} - ${buildStatus}*\n_Job:_ `${env.JOB_NAME}`, _Build #_ `${env.BUILD_NUMBER}`"
    def summary = "started \n\n Job Name: ${env.JOB_NAME} \n\n Build URL: (<${env.BUILD_URL}|Open>) \n\n Author: ${GIT_AUTHOR_NAME} \n\n COMMIT MESSAGE: ${GIT_COMMIT_MESSAGE} \n\n TRIGGER: ${TRIGGER}"
    // Override default values based on build status
    if (buildStatus == 'STARTED') {
        colorCode = '#F79D12'
    } else if (buildStatus == 'SUCCESS') {
        summary = "Completed \n\n Job Name: ${env.JOB_NAME} \n\n Build URL: (<${env.BUILD_URL}|Open>)" 
        colorCode = '#18D205'
    } else {
        colorCode = '#F32007'
    }
	
	// office365ConnectorSend message: summary, status: buildStatus, webhookUrl: 'https://outlook.office.com/webhook/27c0e0b5-f615-43e1-bf17-34b59b83dbe4@15c06421-f9b2-4764-8696-50765d1efbda/JenkinsCI/23e1f1b00d7541f9b8a1425df0efa3b8/5582f9fa-a2d6-4454-a70c-42a4f415db8c', color: colorCode
}
pipeline {
  agent any
  stages {
   stage("Env Build Number") {
      steps{
         echo "The build number is ${env.BUILD_NUMBER}"
         echo "You can also use \${BUILD_NUMBER} -> ${BUILD_NUMBER}" 
         sh 'echo $?'
            }
        }
    stage('Build') {
      parallel {
        stage('Build') {
          steps {
            sh 'echo "building the repo"'
          }
        }
      }
    }

    stage('Test') {
      steps {
        sh 'python3 test_app.py'
        input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
      }
    }

    stage('Deploy')
    {
      steps {
        echo "deploying the application"
      }
    }

  }

  post {
        always {
            echo 'The pipeline completed'
            junit allowEmptyResults: true, testResults:'**/test_reports/*.xml'
        }
        success {
            
            sh "sudo nohup python3 app.py > log.txt 2>&1 &"
            echo "Flask Application Up and running!!"
        }
        failure {
            echo 'Build stage failed'
            error('Stopping early…')
        }
      }
}
