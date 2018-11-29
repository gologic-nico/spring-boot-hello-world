node {
    stage("Checkout") {
      deleteDir()
      checkout scm
    }

    docker.image('uitests/docker-maven-chrome').inside {
        stage('Maven Clean') {
            sh "mvn clean -Dit.skip=false"
        }

        stage('Artefact Package') {
            sh "mvn package -DskipTests"
        }

        stage('Boot Hello World') {
            sh "nohup java -jar target/spring-boot-hello-world-1.0.0-SNAPSHOT.jar &"
        }

        sleep 15

        boolean isRobotFailed = false

        try {
            stage('Robot Test') {
                sh "mvn clean org.robotframework:robotframework-maven-plugin:run"
            }
        } catch (Exception e) {
            echo "Robot test error..."
            isError = true
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
}
