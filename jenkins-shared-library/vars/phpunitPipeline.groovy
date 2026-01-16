def call(Map config) {
    pipeline {
        agent any
        environment {
            DOCKERHUB_CREDS = credentials('walkero-dockerhub')
            AWS_CREDS = credentials('aws-ec2-credentials')
            AWS_DEFAULT_REGION = "eu-north-1"
            DOCKERHUB_REPO = config.dockerhubRepo ?: "walkero/phpunit-alpine"
            // Version mappings
            XDEBUG_VER_35 = config.xdebugVersions?.v35 ?: "3.5.0"
            XDEBUG_VER_31 = config.xdebugVersions?.v31 ?: "3.1.6"
            PHPUNIT_VER_12 = config.phpunitVersions?.v12 ?: "12.5.5"
            PHPUNIT_VER_11 = config.phpunitVersions?.v11 ?: "11.5.47"
            PHPUNIT_VER_10 = config.phpunitVersions?.v10 ?: "10.5.60"
            PHPUNIT_VER_9 = config.phpunitVersions?.v9 ?: "9.6.31"
            PHPUNIT_VER_8 = config.phpunitVersions?.v8 ?: "8.5.50"
        }
        stages {
            stage('aws-poweron') {
                when { branch 'master' }
                steps {
                    script {
                        if (config.awsInstanceId) {
                            sh """
                                aws ec2 start-instances --instance-ids ${config.awsInstanceId}
                            """
                        }
                    }
                }
            }
            stage('build-images') {
                when { branch 'master' }
                matrix {
                    agent { label "agent-${ARCH}" }
                    axes {
                        org.walkero.PhpunitConfig.getAxes(config)
                    }
                    excludes {
                        org.walkero.PhpunitConfig.getExcludes(config)
                    }
                    stages {
                        stage('build') {
                            steps {
                                script {
                                    def versions = org.walkero.PhpunitConfig.getVersions(env.PHPUNIT, env.PHP, env)
                                    sh """
                                        docker build \\
                                            --cache-from \${DOCKERHUB_REPO}:php\${PHP}-phpunit\${PHPUNIT}-\${ARCH} \\
                                            --build-arg PHP_VER=\${PHP} \\
                                            --build-arg PHPUNIT_VER=${versions.phpunit} \\
                                            --build-arg XDEBUG_VER=${versions.xdebug} \\
                                            -t \${DOCKERHUB_REPO}:php\${PHP}-phpunit\${PHPUNIT}-\${ARCH} \\
                                            -f Dockerfile .
                                    """
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
                    }
                    post {
                        always {
                            sh 'docker logout'
                        }
                    }
                }
            }
            stage('create-manifests') {
                when { branch 'master' }
                matrix {
                    axes {
                        org.walkero.PhpunitConfig.getManifestAxes(config)
                    }
                    excludes {
                        org.walkero.PhpunitConfig.getExcludes(config)
                    }
                    stages {
                        stage('create') {
                            steps {
                                sh '''
                                    docker manifest create \\
                                        --amend ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT} \\
                                        ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-amd64 \\
                                        ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}-arm64
                                '''
                            }
                        }
                        stage('push-manifests') {
                            steps {
                                sh '''
                                    echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                                    docker manifest push ${DOCKERHUB_REPO}:php${PHP}-phpunit${PHPUNIT}
                                    docker logout
                                '''
                            }
                        }
                    }
                }
            }
        }
    }
}