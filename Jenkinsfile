pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		DOCKERHUB_REPO="walkero/amigagccondocker"
	}
	stages {
		stage('aws-poweron') {
			when { buildingTag() }
			steps {
				sh '''
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754 i-02bb3cbe63a2b3fef
				'''
			}
		}
		stage('build-images') {
			when { buildingTag() }
			matrix {
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
					axis {
						name 'GCC'
						values '11', '8'
					}
				}
				agent { label "aws-${ARCH}" }
				stages {
					stage('build') {
						steps {
							sh '''
								cd ppc-amigaos
								docker build \
									--cache-from ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${ARCH} \
									--build-arg GCC_VER=${GCC} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}-${ARCH} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${ARCH} \
									-f Dockerfile .
							'''
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
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}-${ARCH}
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${ARCH}
							'''
						}
					}
					stage('remove-images') {
						steps {
							sh '''
								docker image ls
								docker rmi -f $(docker images --filter=reference="${DOCKERHUB_REPO}:*" -q)
								docker image prune -a --force
								docker image ls
							'''
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
		stage('create-manifests') {
			when { buildingTag() }
			matrix {
				axes {
					axis {
						name 'GCC'
						values '11', '8'
					}
				}
				stages {
					stage('create') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME} \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}-arm64

								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC}-base \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-base-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-base-arm64
							'''
						}
					}
					stage('push-manifests') {
						when { buildingTag() }
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}-base
								docker logout
							'''
						}
					}
					stage('clear-manifests') {
						when { buildingTag() }
						steps {
							sh '''
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-base-${TAG_NAME}
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-base
							'''
						}
					}
				}
			}
		}
	}
}
