local buildMain(_arch='amd64', _phpUnitVer, _phpVersions) =
	local _xdebugVer = '3.2.2';
	local _phpUnitMajor = std.split(_phpUnitVer, '.');
	{
		"kind": 'pipeline',
		"type": 'docker',
		"name": 'phpunit' + _phpUnitMajor[0] + '-' + _arch,
		"platform": {
			"arch": _arch,
			"os": 'linux'
		},
		"steps": [
			{
				"name": 'deploy-' + _php + '-phpunit-' + _phpUnitMajor[0],
				"pull": 'always',
				"image": 'plugins/docker',
				"settings": {
					"repo": 'walkero/phpunit-alpine',
					"tags": [
						'php' + _php + '-phpunit' + _phpUnitMajor[0] + '-' + _arch
					],
					"cache_from": [
						'walkero/phpunit-alpine:php' + _php + '-phpunit' + _phpUnitMajor[0] + '-' + _arch
					],
					"dockerfile": 'Dockerfile',
					"purge": true,
					// "dry_run": true,
					"compress": true,
					"build_args": [
						'PHP_VER=' + _php,
						'PHPUNIT_VER=' + _phpUnitVer,
						'XDEBUG_VER=' + _xdebugVer
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
					'master'
				]
			},
			"event": {
				"include": [
					'push'
				]
			}
		},
		"depends_on": [
			'awsbuilders-poweron'
		],
		"node": {
			"agents": 'awsbuilders'
		}
	};

{
	phpunit10: {
		'amd': buildMain('amd64', '10.3.2', ['8.1', '8.2']),
		'arm': buildMain('arm64', '10.3.2', ['8.1', '8.2']),
	},
	phpunit9: {
		'amd': buildMain('amd64', '9.6.10', ['7.3', '7.4', '8.0', '8.1', '8.2']),
		'arm': buildMain('arm64', '9.6.10', ['7.3', '7.4', '8.0', '8.1', '8.2']),
	},
	phpunit8: {
		'amd': buildMain('amd64', '8.5.33', ['7.2', '7.3', '7.4', '8.0', '8.1', '8.2']),
		'arm': buildMain('arm64', '8.5.33', ['7.2', '7.3', '7.4', '8.0', '8.1', '8.2']),
	},
	phpunit7: {
		'amd': buildMain('amd64', '7.5.20', ['7.1', '7.2', '7.3']),
		'arm': buildMain('arm64', '7.5.20', ['7.1', '7.2', '7.3']),
	},
	phpunit6: {
		'amd': buildMain('amd64', '6.5.14', ['7.1', '7.2']),
		'arm': buildMain('arm64', '6.5.14', ['7.1', '7.2']),
	},
	phpunit5: {
		'amd': buildMain('amd64', '5.7.27', ['5.6', '7.1']),
		'arm': buildMain('arm64', '5.7.27', ['5.6', '7.1']),
	}
}
