pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		DOCKERHUB_REPO="walkero/phpunit-alpine"
		// Xdebug version variables - easy to update
		XDEBUG_VER_35="3.5.0"
		XDEBUG_VER_34="3.4.7"
		XDEBUG_VER_33="3.3.2"
		XDEBUG_VER_31="3.1.6"
		// PHPUnit version mappings
		PHPUNIT_VER_11="11.4.3"
		PHPUNIT_VER_10="10.5.38"
		PHPUNIT_VER_9="9.6.21"
		PHPUNIT_VER_8="8.5.40"
	}
	stages {
		stage('aws-poweron') {
			when { branch 'master' }
			steps {
				sh '''
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754
				'''
			}
		}
		stage('build-images') {
			when { branch 'master' }
			matrix {
				agent { label "agent-${ARCH}" }
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
					axis {
						name 'PHPUNIT'
						values '12', '11', '10', '9', '8'
					}
					axis {
						name 'PHP'
						values '7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'
					}
				}
				excludes {
					// phpunit 12: only PHP 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '12'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4', '8.1', '8.2'
						}
					}
					// phpunit 11: only PHP 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '11'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4', '8.1'
						}
					}
					// phpunit 10: only PHP 8.1, 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '10'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4'
						}
					}
					// phpunit 9: only PHP 7.3, 7.4, 8.1, 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '9'
						}
						axis {
							name 'PHP'
							values '7.2'
						}
					}
				}
				stages {
					stage('build') {
						steps {
							script {								
								// Determine PHPUnit and XDebug full versions
								def PHPUNIT_VER
								def XDEBUG_VER
								switch(env.PHPUNIT) {
									case '12':
										PHPUNIT_VER = env.PHPUNIT_VER_11
										if (env.PHP in ['8.4', '8.5']) {
											XDEBUG_VER = env.XDEBUG_VER_35
										} else {
											XDEBUG_VER = env.XDEBUG_VER_34
										}
										break
									case '11':
										PHPUNIT_VER = env.PHPUNIT_VER_11
										if (env.PHP in ['8.4', '8.5']) {
											XDEBUG_VER = env.XDEBUG_VER_35
										} else {
											XDEBUG_VER = env.XDEBUG_VER_33
										}
										break
									case '10':
										PHPUNIT_VER = env.PHPUNIT_VER_10
										if (env.PHP in ['8.4', '8.5']) {
											XDEBUG_VER = env.XDEBUG_VER_35
										} else {
											XDEBUG_VER = env.XDEBUG_VER_33
										}
										break
									case '9':
										PHPUNIT_VER = env.PHPUNIT_VER_9
										if (env.PHP in ['8.4', '8.5']) {
											XDEBUG_VER = env.XDEBUG_VER_35
										} else if (env.PHP in ['8.1', '8.2', '8.3']) {
											XDEBUG_VER = env.XDEBUG_VER_33
										} else {
											XDEBUG_VER = env.XDEBUG_VER_31
										}
										break
									case '8':
										PHPUNIT_VER = env.PHPUNIT_VER_8
										if (env.PHP in ['8.4', '8.5']) {
											XDEBUG_VER = env.XDEBUG_VER_34
										} else if (env.PHP in ['8.1', '8.2', '8.3']) {
											XDEBUG_VER = env.XDEBUG_VER_33
										} else {
											XDEBUG_VER = env.XDEBUG_VER_31
										}
										break
									default:
										PHPUNIT_VER = env.PHPUNIT
								}
								sh '''
									docker build \
										--cache-from ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										--build-arg PHP_VER=${PHP} \
										--build-arg PHPUNIT_VER=${PHPUNIT_VER} \
										--build-arg XDEBUG_VER=${XDEBUG_VER} \
										-t ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH} \
										-f Dockerfile .
								'''
							}
						}
					}
					stage('dockerhub-login') {
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
							'''
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-${ARCH}
							'''
						}
					}
					// stage('remove-images') {
					// 	steps {
					// 		sh '''
					// 			docker image ls
					// 			docker rmi -f $(docker images --filter=reference="${DOCKERHUB_REPO}:*" -q)
					// 			docker image prune -a --force
					// 			docker image ls
					// 		'''
					// 	}
					// }
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
		stage('create-manifests') {
			when { branch 'master' }
			matrix {
				axes {
					axis {
						name 'PHPUNIT'
						values '12', '11', '10', '9', '8'
					}
					axis {
						name 'PHP'
						values '7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'
					}
				}
				excludes {
					// phpunit 12: only PHP 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '12'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4', '8.1', '8.2'
						}
					}
					// phpunit 11: only PHP 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '11'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4', '8.1'
						}
					}
					// phpunit 10: only PHP 8.1, 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '10'
						}
						axis {
							name 'PHP'
							values '7.2', '7.3', '7.4'
						}
					}
					// phpunit 9: only PHP 7.3, 7.4, 8.1, 8.2, 8.3, 8.4
					exclude {
						axis {
							name 'PHPUNIT'
							values '9'
						}
						axis {
							name 'PHP'
							values '7.2'
						}
					}
				}
				stages {
					stage('create') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \
									${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64
							'''
						}
					}
					stage('push-manifests') {
						when { branch 'master' }
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
								docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
								docker logout
							'''
						}
					}
					// stage('clear-manifests') {
					// 	when { branch 'master' }
					// 	steps {
					// 		sh '''
					// 			docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}
					// 			docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-base
					// 		'''
					// 	}
					// }
				}
			}
		}
	}
}
