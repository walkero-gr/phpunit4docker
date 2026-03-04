pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		DOCKERHUB_REPO="walkero/phpunit-alpine"
		// Xdebug version variables - easy to update
		XDEBUG_VER_35="3.5.0"
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
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '13'
								env.PHPUNIT_VER = env.PHPUNIT_VER_13
								env.XDEBUG_VER = env.XDEBUG_VER_35
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
		stage('build-phpunit-12') {
			when { branch 'master' }
			stages {
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '12'
								env.PHPUNIT_VER = env.PHPUNIT_VER_12
								env.XDEBUG_VER = env.XDEBUG_VER_35
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
		stage('build-phpunit-11') {
			when { branch 'master' }
			stages {
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '11'
								env.PHPUNIT_VER = env.PHPUNIT_VER_11
								env.XDEBUG_VER = env.XDEBUG_VER_35
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
		stage('build-phpunit-10') {
			when { branch 'master' }
			stages {
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '10'
								env.PHPUNIT_VER = env.PHPUNIT_VER_10
								env.XDEBUG_VER = env.XDEBUG_VER_35
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
		stage('build-phpunit-9') {
			when { branch 'master' }
			stages {
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '9'
								env.PHPUNIT_VER = env.PHPUNIT_VER_9
								if (env.PHP in ['8.1', '8.2', '8.3', '8.4', '8.5']) {
									env.XDEBUG_VER = env.XDEBUG_VER_35
								} else if (env.PHP in ['7.2', '7.3', '7.4']) {
									env.XDEBUG_VER = env.XDEBUG_VER_31
								}
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
		stage('build-phpunit-8') {
			when { branch 'master' }
			stages {
				stage('dockerhub-login') {
					steps {
						sh '''
							echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
						'''
					}
				}
			}
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
					stage('build') {
						steps {
							script {
								env.PHPUNIT = '8'
								env.PHPUNIT_VER = env.PHPUNIT_VER_8
								if (env.PHP in ['8.1', '8.2', '8.3', '8.4', '8.5']) {
									env.XDEBUG_VER = env.XDEBUG_VER_35
								} else if (env.PHP in ['7.2', '7.3', '7.4']) {
									env.XDEBUG_VER = env.XDEBUG_VER_31
								}
								sh '''
									docker buildx build \
										--progress plain \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										--provenance false \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					stage('push-manifest') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64

								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
							'''
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
