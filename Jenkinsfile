@Library('phpunit-repo-shared-library') _

phpunitPipeline([
    dockerhubRepo: 'walkero/phpunit-alpine',
    awsInstanceId: 'i-07474e4fe80f14754',
    architectures: ['amd64', 'arm64'],
    phpunitVersions: ['12', '11', '10', '9', '8'],
    phpVersions: ['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5'],
    phpunitVersions: [
        v12: '12.5.5',
        v11: '11.5.47',
        v10: '10.5.60',
        v9: '9.6.31',
        v8: '8.5.50'
    ],
    xdebugVersions: [
        v35: '3.5.0',
        v31: '3.1.6'
    ]
])