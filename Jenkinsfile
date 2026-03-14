pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		DOCKERHUB_REPO="walkero/phpunit-alpine"
		XDEBUG_VER_35="3.5.1"
		XDEBUG_VER_31="3.1.6"
		PHPUNIT_VER_13="13.0.5"
		PHPUNIT_VER_12="12.5.14"
		PHPUNIT_VER_11="11.5.55"
		PHPUNIT_VER_10="10.5.63"
		PHPUNIT_VER_9="9.6.34"
		PHPUNIT_VER_8="8.5.52"
	}
	stages {
		stage('build-phpunit-13') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '13', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '13', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '13', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '13', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['8.4', '8.5'], '13')
						}
					}
				}
			}
		}
		stage('build-phpunit-12') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php8.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.3', '12', 'amd64') } }
						}
						stage('php8.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.3', '12', 'arm64') } }
						}
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '12', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '12', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '12', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '12', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['8.3', '8.4', '8.5'], '12')
						}
					}
				}
			}
		}
		stage('build-phpunit-11') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php8.2-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.2', '11', 'amd64') } }
						}
						stage('php8.2-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.2', '11', 'arm64') } }
						}
						stage('php8.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.3', '11', 'amd64') } }
						}
						stage('php8.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.3', '11', 'arm64') } }
						}
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '11', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '11', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '11', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '11', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['8.2', '8.3', '8.4', '8.5'], '11')
						}
					}
				}
			}
		}
		stage('build-phpunit-10') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php8.1-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.1', '10', 'amd64') } }
						}
						stage('php8.1-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.1', '10', 'arm64') } }
						}
						stage('php8.2-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.2', '10', 'amd64') } }
						}
						stage('php8.2-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.2', '10', 'arm64') } }
						}
						stage('php8.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.3', '10', 'amd64') } }
						}
						stage('php8.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.3', '10', 'arm64') } }
						}
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '10', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '10', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '10', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '10', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['8.1', '8.2', '8.3', '8.4', '8.5'], '10')
						}
					}
				}
			}
		}
		stage('build-phpunit-9') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php7.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('7.3', '9', 'amd64') } }
						}
						stage('php7.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('7.3', '9', 'arm64') } }
						}
						stage('php7.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('7.4', '9', 'amd64') } }
						}
						stage('php7.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('7.4', '9', 'arm64') } }
						}
						stage('php8.1-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.1', '9', 'amd64') } }
						}
						stage('php8.1-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.1', '9', 'arm64') } }
						}
						stage('php8.2-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.2', '9', 'amd64') } }
						}
						stage('php8.2-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.2', '9', 'arm64') } }
						}
						stage('php8.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.3', '9', 'amd64') } }
						}
						stage('php8.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.3', '9', 'arm64') } }
						}
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '9', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '9', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '9', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '9', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'], '9')
						}
					}
				}
			}
		}
		stage('build-phpunit-8') {
			when { branch 'master' }
			stages {
				stage('build images') {
					parallel {
						stage('php7.2-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('7.2', '8', 'amd64') } }
						}
						stage('php7.2-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('7.2', '8', 'arm64') } }
						}
						stage('php7.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('7.3', '8', 'amd64') } }
						}
						stage('php7.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('7.3', '8', 'arm64') } }
						}
						stage('php7.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('7.4', '8', 'amd64') } }
						}
						stage('php7.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('7.4', '8', 'arm64') } }
						}
						stage('php8.1-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.1', '8', 'amd64') } }
						}
						stage('php8.1-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.1', '8', 'arm64') } }
						}
						stage('php8.2-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.2', '8', 'amd64') } }
						}
						stage('php8.2-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.2', '8', 'arm64') } }
						}
						stage('php8.3-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.3', '8', 'amd64') } }
						}
						stage('php8.3-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.3', '8', 'arm64') } }
						}
						stage('php8.4-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.4', '8', 'amd64') } }
						}
						stage('php8.4-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.4', '8', 'arm64') } }
						}
						stage('php8.5-amd64') {
							agent { label 'agent-amd64' }
							steps { script { buildAndPush('8.5', '8', 'amd64') } }
						}
						stage('php8.5-arm64') {
							agent { label 'agent-arm64' }
							steps { script { buildAndPush('8.5', '8', 'arm64') } }
						}
					}
				}
				stage('push manifests') {
					steps {
						script {
							createAndPushManifests(['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'], '8')
						}
					}
				}
			}
		}
	}
}

def buildAndPush(phpVer, phpunitNum, arch) {
	def phpunitVersions = [
		'13': env.PHPUNIT_VER_13,
		'12': env.PHPUNIT_VER_12,
		'11': env.PHPUNIT_VER_11,
		'10': env.PHPUNIT_VER_10,
		'9': env.PHPUNIT_VER_9,
		'8': env.PHPUNIT_VER_8
	]
	def phpunitVer = phpunitVersions[phpunitNum]
	def xdebugVer = (phpVer in ['7.2', '7.3', '7.4']) ? env.XDEBUG_VER_31 : env.XDEBUG_VER_35
	def imageTagBase = "${env.DOCKERHUB_REPO}:php${phpVer}-phpunit${phpunitNum}"

	try {
		sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
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
		retry(3) {
			sh "docker push ${imageTagBase}-${arch}"
		}
	} finally {
		sh 'docker logout'
	}
}

def createAndPushManifests(phpVersions, phpunitNum) {
	phpVersions.each { phpVer ->
		def imageTagBase = "${env.DOCKERHUB_REPO}:php${phpVer}-phpunit${phpunitNum}"
		sh """
			docker manifest rm ${imageTagBase} || true
			docker manifest create \
				${imageTagBase} \
				${imageTagBase}-amd64 \
				${imageTagBase}-arm64
		"""
	}

	try {
		sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
		phpVersions.each { phpVer ->
			def imageTagBase = "${env.DOCKERHUB_REPO}:php${phpVer}-phpunit${phpunitNum}"
			retry(3) {
				sh "docker manifest push ${imageTagBase}"
			}
		}
	} finally {
		sh 'docker logout'
	}
}
