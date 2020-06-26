@Library(value= 'sipl-shared-lib@master', changelog=false)_ 

node("agent-complet") {

    stage("Hello World") {
      deleteDir()
      echo "Hello World Desjardins EEP"
    }

    stage('Call HP ALM From SIPL Lib') {
        def hpAlmMaps = [ hpalmCredentialId: "HPALM_USER", domain: "SPE", project: "POC_PERENNITE", campaignId: "291"]

        hpalm hpAlmMaps
    }
}
