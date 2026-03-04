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
		stage('build-phpunit-13') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '13', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
						}
					}
				}
			}
		}
		stage('build-phpunit-12') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '8.3', '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '12', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
						}
					}
				}
			}
		}
		stage('build-phpunit-11') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '8.2', '8.3', '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '11', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
						}
					}
				}
			}
		}
		stage('build-phpunit-10') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '8.1', '8.2', '8.3', '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '10', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
						}
					}
				}
			}
		}
		stage('build-phpunit-9') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '9', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
						}
					}
				}
			}
		}
		stage('build-phpunit-8') {
			when { branch 'master' }
			stages {
				stage('build-and-push') {
					matrix {
						agent { label "agent-${ARCH}" }
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'PHP'
								values '7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'
							}
						}
						stages {
							stage('docker-login') {
								steps {
									sh '''
										echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
									'''
								}
							}
							stage('build-and-push') {
								steps {
									script {
										buildAndPush(env.PHP, '8', env.ARCH)
									}
								}
							}
						}
					}
					post {
						always {
							sh '''
								docker logout
							'''
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
			# Manifest exists, amend it
			docker manifest create \
				--amend ${imageTagBase} \
				${imageTagBase}-amd64 \
				${imageTagBase}-arm64
		else
			# Manifest doesn't exist, create it
			docker manifest create \
				${imageTagBase} \
				${imageTagBase}-amd64 \
				${imageTagBase}-arm64
		fi

		docker manifest push ${imageTagBase}
	"""
}
