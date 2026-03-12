pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		DOCKERHUB_REPO="walkero/phpunit-alpine"
		// Xdebug version variables - easy to update
		XDEBUG_VER_35="3.5.1"
		XDEBUG_VER_31="3.1.6"
		// PHPUnit version mappings
		PHPUNIT_VER_13="13.0.5"
		PHPUNIT_VER_12="12.5.14"
		PHPUNIT_VER_11="11.5.55"
		PHPUNIT_VER_10="10.5.63"
		PHPUNIT_VER_9="9.6.34"
		PHPUNIT_VER_8="8.5.52"
	}
	stages {
		stage('build-phpunit') {
			when { branch 'master' }
			steps {
				script {
					def phpunitConfigs = [
						'13': ['8.4', '8.5'],
						'12': ['8.3', '8.4', '8.5'],
						'11': ['8.2', '8.3', '8.4', '8.5'],
						'10': ['8.1', '8.2', '8.3', '8.4', '8.5'],
						'9':  ['7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'],
						'8':  ['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5']
					]

					def branches = [:]
					phpunitConfigs.each { phpunitNum, phpVersions ->
						phpVersions.each { php ->
							['amd64', 'arm64'].each { arch ->
								def pNum = phpunitNum
								def pVer = php
								def pArch = arch
								branches["phpunit${pNum}-php${pVer}-${pArch}"] = {
									node("agent-${pArch}") {
										try {
											sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
											buildAndPush(pVer, pNum, pArch)
										} finally {
											sh 'docker logout'
										}
									}
								}
							}
						}
					}
					parallel branches
				}
			}
		}
	}
}

def buildAndPush(phpVer, phpunitNum, arch) {
	// Map PHPUnit version numbers to their full versions
	def phpunitVersions = [
		'13': env.PHPUNIT_VER_13,
		'12': env.PHPUNIT_VER_12,
		'11': env.PHPUNIT_VER_11,
		'10': env.PHPUNIT_VER_10,
		'9': env.PHPUNIT_VER_9,
		'8': env.PHPUNIT_VER_8
	]
	def phpunitVer = phpunitVersions[phpunitNum]

	// Build image
	def xdebugVer = (phpVer in ['7.2', '7.3', '7.4']) ? env.XDEBUG_VER_31 : env.XDEBUG_VER_35

	def imageTagBase = "${env.DOCKERHUB_REPO}:php${phpVer}-phpunit${phpunitNum}"

	sh """
		docker buildx build \
			--progress plain \
			--cache-from ${imageTagBase}-${arch} \
			--build-arg PHP_VER=${phpVer} \
			--build-arg PHPUNIT_VER=${phpunitVer} \
			--build-arg XDEBUG_VER=${xdebugVer} \
			--provenance false \
			-t ${imageTagBase}-${arch} \
			-f Dockerfile .
	"""

	// Push image
	sh "docker push ${imageTagBase}-${arch}"

	// Create and push manifest
	sh """
		if docker manifest inspect ${imageTagBase} > /dev/null 2>&1; then
			# Manifest exists, remove it
			docker manifest rm ${imageTagBase}
		fi

		# Manifest doesn't exist, create it
		docker manifest create \
			${imageTagBase} \
			${imageTagBase}-amd64 \
			${imageTagBase}-arm64

		docker manifest push ${imageTagBase}
	"""
}
