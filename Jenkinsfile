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
			parallel {
				stage('build-phpunit-13') {
					steps {
						script {
							def branches = [:]
							['8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '13', pArch)
											} finally {
												sh 'docker logout'
											}
										}
									}
								}
							}
							parallel branches
						}
					}
				}
				stage('build-phpunit-12') {
					steps {
						script {
							def branches = [:]
							['8.3', '8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '12', pArch)
											} finally {
												sh 'docker logout'
											}
										}
									}
								}
							}
							parallel branches
						}
					}
				}
				stage('build-phpunit-11') {
					steps {
						script {
							def branches = [:]
							['8.2', '8.3', '8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '11', pArch)
											} finally {
												sh 'docker logout'
											}
										}
									}
								}
							}
							parallel branches
						}
					}
				}
				stage('build-phpunit-10') {
					steps {
						script {
							def branches = [:]
							['8.1', '8.2', '8.3', '8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '10', pArch)
											} finally {
												sh 'docker logout'
											}
										}
									}
								}
							}
							parallel branches
						}
					}
				}
				stage('build-phpunit-9') {
					steps {
						script {
							def branches = [:]
							['7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '9', pArch)
											} finally {
												sh 'docker logout'
											}
										}
									}
								}
							}
							parallel branches
						}
					}
				}
				stage('build-phpunit-8') {
					steps {
						script {
							def branches = [:]
							['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'].each { php ->
								['amd64', 'arm64'].each { arch ->
									def pVer = php
									def pArch = arch
									branches["php${pVer}-${pArch}"] = {
										node("agent-${pArch}") {
											try {
												sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
												buildAndPush(pVer, '8', pArch)
											} finally {
												sh 'docker logout'
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
