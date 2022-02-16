
pipeline {
  agent any
  stages {
        stage('Build') {
          steps {
            sh 'echo "building the repo"'
          }
        }

    stage('Test') {
      steps {
        sh 'python3 test_app.py'
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
	    sh 'echo $?'
	    sh "git tag ${env.BUILD_NUMBER}"
        }
        failure {
            echo 'Build stage failed'
            error('Stopping early…')
        }
      }
}