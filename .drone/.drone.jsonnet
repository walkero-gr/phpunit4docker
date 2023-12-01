local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],
	buildMain.phpunit10.amd,
	buildMain.phpunit10.arm,
	buildManifest.phpunit10,
	buildMain.phpunit9_3.3.amd,
	buildMain.phpunit9_3.3.arm,
	buildMain.phpunit9_3.1.amd,
	buildMain.phpunit9_3.1.arm,
	buildManifest.phpunit9,
	buildMain.phpunit8_3.3.amd,
	buildMain.phpunit8_3.3.arm,
	buildMain.phpunit8_3.1.amd,
	buildMain.phpunit8_3.1.arm,
	buildManifest.phpunit8,
	buildMain.phpunit7.amd,
	buildMain.phpunit7.arm,
	buildManifest.phpunit7,
	buildMain.phpunit6.amd,
	buildMain.phpunit6.arm,
	buildManifest.phpunit6,
	buildMain.phpunit5.amd,
	buildMain.phpunit5.arm,
	buildManifest.phpunit5,
]
