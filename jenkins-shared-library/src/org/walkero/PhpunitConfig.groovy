package org.walkero

class PhpunitConfig {
    static def getAxes(Map config) {
        return {
            axis {
                name 'ARCH'
                values config.architectures ?: ['amd64', 'arm64']
            }
            axis {
                name 'PHPUNIT'
                values config.phpunitVersions ?: ['12', '11', '10', '9', '8']
            }
            axis {
                name 'PHP'
                values config.phpVersions ?: ['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5']
            }
        }
    }
    
    static def getManifestAxes(Map config) {
        return {
            axis {
                name 'PHPUNIT'
                values config.phpunitVersions ?: ['12', '11', '10', '9', '8']
            }
            axis {
                name 'PHP'
                values config.phpVersions ?: ['7.2', '7.3', '7.4', '8.1', '8.2', '8.3', '8.4', '8.5']
            }
        }
    }
    
    static def getExcludes(Map config) {
        def excludes = config.excludes ?: getDefaultExcludes()
        return {
            excludes.each { excludeRule ->
                exclude {
                    axis {
                        name 'PHPUNIT'
                        values excludeRule.phpunit
                    }
                    axis {
                        name 'PHP'
                        values excludeRule.php
                    }
                }
            }
        }
    }
    
    static def getDefaultExcludes() {
        return [
            [phpunit: '12', php: ['7.2', '7.3', '7.4', '8.1', '8.2']],
            [phpunit: '11', php: ['7.2', '7.3', '7.4', '8.1']],
            [phpunit: '10', php: ['7.2', '7.3', '7.4']],
            [phpunit: '9', php: ['7.2']]
        ]
    }
    
    static def getVersions(String phpunit, String php, Map env) {
        def phpunitVer = env."PHPUNIT_VER_${phpunit}" ?: phpunit
        def xdebugVer
        
        if (php in ['8.1', '8.2', '8.3', '8.4', '8.5']) {
            xdebugVer = env.XDEBUG_VER_35
        } else if (php in ['7.2', '7.3', '7.4']) {
            xdebugVer = env.XDEBUG_VER_31
        } else {
            xdebugVer = env.XDEBUG_VER_31
        }
        
        return [
            phpunit: phpunitVer,
            xdebug: xdebugVer
        ]
    }
}