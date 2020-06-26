@Library(value= 'sipl-shared-lib@master', changelog=false)_ 

node("agent-complet") {

    stage("Hello World") {
      deleteDir()
      echo "Hello World Desjardins EEP"
    }

    stage('Call HP ALM From SIPL Lib') {
        hpalm "HPALM_USER", "SPE", "POC_PERENNITE", "291"
    }
}
