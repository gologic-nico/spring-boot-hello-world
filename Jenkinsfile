@Library(value= 'sipl-shared-lib@master', changelog=false)_ 

node("agent-complet") {
    stage("Checkout") {
      deleteDir()
      checkout scm
    }

    stage('Maven Clean') {
        mvn.with {
            sh "mvn clean -Dit.skip=false"
        }
    }

    boolean isRobotFailed = false

    try {
        stage('Robot Test') {
            mvn.with {
                sh "mvn clean org.robotframework:robotframework-maven-plugin:run"
            }
        }
    } catch (Exception e) {
        echo "Robot test error..."
        isRobotFailed = true
    }finally{
        stage('Robot Report') {
            step([
                $class : 'RobotPublisher',
                outputPath : "target/robotframework-reports",
                outputFileName : "*.xml",
                disableArchiveOutput : false,
                passThreshold : 100,
                unstableThreshold: 95.0,
                otherFiles : "*.png",
            ])
        }

        stage('Artefact Archive') {
            // Archive the build output artifacts.
            archiveArtifacts artifacts: 'target/*.jar,target/robotframework-reports/*.*' 
        }
    }

    if(isRobotFailed){
        error "Robot Test Failed. Check log file!" 
    }
}
