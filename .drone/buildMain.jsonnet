local buildMain(_arch='amd64', _phpUnitVer, _componentsVersions) =
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
				"name": 'deploy-' + _comp[0] + '-phpunit-' + _phpUnitMajor[0],
				"pull": 'always',
				"image": 'plugins/docker',
				"settings": {
					"repo": 'walkero/phpunit-alpine',
					"tags": [
						'php' + _comp[0] + '-phpunit' + _phpUnitMajor[0] + '-' + _arch
					],
					"cache_from": [
						'walkero/phpunit-alpine:php' + _comp[0] + '-phpunit' + _phpUnitMajor[0] + '-' + _arch
					],
					"dockerfile": 'Dockerfile',
					"purge": true,
					// "dry_run": true,
					"compress": true,
					"build_args": [
						'PHP_VER=' + _comp[0],
						'PHPUNIT_VER=' + _phpUnitVer,
						'XDEBUG_VER=' + _comp[1]
					],
					"username": {
						"from_secret": 'DOCKERHUB_USERNAME'
					},
					"password": {
						"from_secret": 'DOCKERHUB_PASSWORD'
					},
				}
			}
			for _comp in _componentsVersions
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


local _xdb34 = '3.4.0';
local _xdb33 = '3.3.2';
local _xdb31 = '3.1.6';
local _xdb29 = '2.9.8';
local _xdb25 = '2.5.5';
{
	phpunit11: {
		'amd': buildMain('amd64', '11.4.3', [['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
		'arm': buildMain('arm64', '11.4.3', [['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
	},
	phpunit10: {
		'amd': buildMain('amd64', '10.5.38', [['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
		'arm': buildMain('arm64', '10.5.38', [['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
	},
	phpunit9: {
		'amd': buildMain('amd64', '9.6.21', [['7.3', _xdb31], ['7.4', _xdb31], ['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
		'arm': buildMain('arm64', '9.6.21', [['7.3', _xdb31], ['7.4', _xdb31], ['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
	},
	phpunit8: {
		'amd': buildMain('amd64', '8.5.40', [['7.2', _xdb31], ['7.3', _xdb31], ['7.4', _xdb31], ['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
		'arm': buildMain('arm64', '8.5.40', [['7.2', _xdb31], ['7.3', _xdb31], ['7.4', _xdb31], ['8.1', _xdb33], ['8.2', _xdb33], ['8.3', _xdb33], ['8.4', _xdb34]]),
	},
	phpunit7: {
		'amd': buildMain('amd64', '7.5.20', [['7.1', _xdb29], ['7.2', _xdb29], ['7.3', _xdb29]]),
		'arm': buildMain('arm64', '7.5.20', [['7.1', _xdb29], ['7.2', _xdb29], ['7.3', _xdb29]]),
	},
	phpunit6: {
		'amd': buildMain('amd64', '6.5.14', [['7.1', _xdb29], ['7.2', _xdb29]]),
		'arm': buildMain('arm64', '6.5.14', [['7.1', _xdb29], ['7.2', _xdb29]]),
	},
	phpunit5: {
		'amd': buildMain('amd64', '5.7.27', [['5.6', _xdb25], ['7.1', _xdb29]]),
		'arm': buildMain('arm64', '5.7.27', [['5.6', _xdb25], ['7.1', _xdb29]]),
	}
}
