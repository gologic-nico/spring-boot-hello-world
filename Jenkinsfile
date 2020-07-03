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

        stage('Rapport de tests') {
            // les tests surefire et failsafe sont mergés dans le meme dossier
           junit allowEmptyResults: true, testResults: 'target/robotframework-reports/*.xml'
        }

        stage('Rapport HP ALM') {
            String amlFolder = "Test-Auto\\ROBOT-TEST-UPLOAD"
            // Pusher les résultats de test dans HP ALM
           uploadResultToALM almServerName: 'HPALM', credentialsId: 'HPALM_USER', almDomain: 'SPE', clientType: '', almProject: 'POC_PERENNITE', testingFramework: 'JUnit', testingTool: 'Robot', almTestFolder: amlFolder, almTestSetFolder: amlFolder, almTimeout: '60', testingResultFile: '**/junitResult.xml', jenkinsServerUrl: 'https://sipl.desjardins.com/jkpart'
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
