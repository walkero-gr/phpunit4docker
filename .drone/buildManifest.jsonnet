local buildManifest(_phpUnitVer, _phpVersions) =
	local _phpUnitMajor = std.split(_phpUnitVer, '.');
	{
		"kind": 'pipeline',
		"type": 'docker',
		"name": 'manifest-phpunit-' + _phpUnitMajor[0],
		"steps": [
			{
				"name": 'manifest-php' + _php + '-phpunit' + _phpUnitMajor[0],
				"pull": 'always',
				"image": 'plugins/manifest',
				"settings": {
					"target": 'walkero/phpunit-alpine:php' + _php + '-phpunit' + _phpUnitMajor[0],
					"template": 'walkero/phpunit-alpine:php' + _php + '-phpunit' + _phpUnitMajor[0] + '-ARCH',
					"platforms": [
						'linux/amd64',
						'linux/arm64'
					],
					"username": {
						"from_secret": 'DOCKERHUB_USERNAME'
					},
					"password": {
						"from_secret": 'DOCKERHUB_PASSWORD'
					},
				}
			}
			for _php in _phpVersions
		],
		"trigger": {
			"branch": {
				"include": [
					'master',
					'main'
				]
			},
			"event": {
				"include": [
					'push'
				]
			}
		},
		"depends_on": [
			'phpunit' + _phpUnitMajor[0] + '-amd64',
			'phpunit' + _phpUnitMajor[0] + '-arm64'
		]
	};

{
	phpunit11: buildManifest('11.4.3', ['8.2', '8.3']),
	phpunit10: buildManifest('10.5.38', ['8.1', '8.2', '8.3']),
	phpunit9: buildManifest('9.6.21', ['7.3', '7.4', '8.0', '8.1', '8.2', '8.3']),
	phpunit8: buildManifest('8.5.40', ['7.2', '7.3', '7.4', '8.0', '8.1', '8.2', '8.3']),
	phpunit7: buildManifest('7.5.20', ['7.1', '7.2', '7.3']),
	phpunit6: buildManifest('6.5.14', ['7.1', '7.2']),
	phpunit5: buildManifest('5.7.27', ['5.6', '7.1']),
}
