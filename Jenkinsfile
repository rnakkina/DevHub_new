#!groovy
import groovy.json.JsonSlurperClassic
node {
	def BUILD_NUMBER=env.BUILD_NUMBER
	def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
	def SFDC_USERNAME

	def HUB_ORG='ramakrishna.nakkina@gmail.com'
	def SFDC_HOST='https://login.salesforce.com/'
	def JWT_KEY_CRED_ID='681c2629-6dde-4c9d-bf75-ced2a19c2924'
	def CONNECTED_APP_CONSUMER_KEY='3MVG9vtcvGoeH2bgeNwevBMYDwISQNivcNUtN4i0019mj_XGDyWJ5lOP3notG4aimTe7Q7q6n43bWEX0nCRHr'

	println 'KEY IS'
	println JWT_KEY_CRED_ID
	println HUB_ORG
	println SFDC_HOST
	println CONNECTED_APP_CONSUMER_KEY
	def toolbelt = tool 'toolbelt'
	def rk = 'C:/"Program Files"/sfdx/bin/sfdx'


	stage ('checkout source')
	{
		checkout scm
	}

     withCredentials ([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]){
	stage ('Deploye Code') {
	if (isUnix()){
		rc = sh returnstatus: true, script: "${toolbelt} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
	}else{
		bat "${toolbelt}"
		rc = bat returnstatus: true, script: "${toolbelt} ${rk} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
	}
	if (rc != 0) { error 'hub org authorization failed' }

	println rc
	// need to pull out assigned username
	if (isUnix()) {
		rmsg = sh returnstdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
	}else {
		rmsg = bat returnstdout: true, script: "${toolbelt}/sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
	}
	printf rmsg
	println ('Hello from a Job DSL script!')
	println(rmsg)

	}
   }
}
