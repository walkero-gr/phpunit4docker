# phpunit4docker
**phpunit4docker** is a banch of stand alone docker containers, based on the principle of single logical services per container. These containers can be used from IDEs, like Visual Studio Code and PHPStorm, giving you the ability to experiment with different versions and not rely on the PHPUnit version that exists under vendors folder inside your project.

All the docker images are based on Alpine Linux and have really small footprint, requiring less than 45MB of space.

### Features
- These containers stay alive all the time, as soon as you run them
- Easy usable with docker compose and multiple project installations
- Are based on the principle of single logical services per container
- Cover different versions of PHP and PHPUnit
- Build from official PHP docker images
- PHPUnit is able to generate coverage reports
- Supports PDO MySQL

## Usage
### Available tags

Find the latest tags at [Docker Hub](https://hub.docker.com/r/walkero/phpunit-alpine/tags)

Coverage generation is available for the tags that include xDebug.

| Tag                  | PHP    | PHPUnit  | xDebug   |
| -------------------- | ------ | -------- | -------- | 
| php7.3-phpunit8.2    | 7.3    | 8.2.x    | 2.7.2    |
| php7.3-phpunit7.5    | 7.3    | 7.5.x    | 2.7.2    |
| php7.3-phpunit6.5    | 7.3    | 6.5.x    | 2.7.2    |
| php7.3-phpunit5.7    | 7.3    | 5.7.x    | 2.7.2    |
| php7.2-phpunit8.2    | 7.2    | 8.2.x    | 2.6.1    |
| php7.2-phpunit7.5    | 7.2    | 7.5.x    | 2.6.1    |
| php7.2-phpunit6.5    | 7.2    | 6.5.x    | 2.6.1    |
| php7.2-phpunit5.7    | 7.2    | 5.7.x    | 2.6.1    |
| php7.1-phpunit8.2    | 7.2    | 8.2.x    | 2.6.1    |
| php7.1-phpunit7.5    | 7.1    | 7.5.x    | 2.6.1    |
| php7.1-phpunit6.5    | 7.1    | 6.5.x    | 2.6.1    |
| php7.1-phpunit5.7    | 7.1    | 5.7.x    | 2.6.1    |
| php5.6-phpunit5.7    | 5.6    | 5.7.x    | 2.5.5    |

### Docker Compose
To use these images at your docker-compose yml files, you have to add the following under services:
```yaml
  phpunit:
    image: walkero/phpunit-alpine:php7.3-phpunit7.5
    container_name: "projectname_phpunit"
    volumes:
      - ./public_html:/var/www/html 
```

## VIsual Studio Code

I recommend to use the [Better PHPUnit](https://github.com/calebporzio/better-phpunit) extension.

Add the following settings in your project `settings.json` file.

```json
{
    "better-phpunit.docker.enable": true,
    "better-phpunit.docker.command": "docker exec -it <projectname>_phpunit",
    "better-phpunit.docker.paths": {
        "<your local public_html files path>": "/var/www/html"
    },
    "better-phpunit.phpunitBinary": "phpunit",
    "better-phpunit.xmlConfigFilepath": "/var/www/html/phpunit.xml",
    "better-phpunit.coveragePath": "test/coverage",
    "better-phpunit.coverageFormat": "HTML",
}
```
Consult the extension's documentation about the key compinations or the menu selections you can use to run your tests.

## PHPStorm


1. First, we have to configure the connection to Docker engine:
   * Go to `Preferences -> Build, Execution, Deployment -> Docker`
   * Create a new Docker configuration:
     * for MacOS select `Docker for Mac`
     * For Linux and Windows, select the `TCP socket`. Set the `Engine API URL` to:
       * Linux: `unix:///var/run/docker.sock`
       * Windows: `http://127.0.0.1:2376` or `tcp://localhost:2376`
1. Next, we must configure the remote interpreter:
   * Go to `Preferences -> Languages & Frameworks -> PHP`
   * Create a new PHP CLI interpreter by:
     * Clicking on **...** then **+** and select `From Docker, Vagrant, VM, Remote...`
     * At the radio buttons select `Docker Compose` with the following values:
       * Server: **Docker**
       * Configuration file(s): [select here the project docker-compose.yml file]
       * Service: **phpunit**
     * Click on the `OK` button
     * Now the phpunit docker is added at your CLI Interpreters list at the left. At the right there are the configuration options. Change:
       * Lifecycle to `Connect to existing container ('docker-compose exec')` as these containers run always
     * Click on the `OK` button
1. Time to configure the PHPunit in the project:
   * Go to `Preferences -> Languages & Frameworks -> PHP -> Test Frameworks`
   * Create a new PHPunit configuration by clicking the **+** and select `PHPUnit by Remote interpreter...`
   * Select from the list the phpunit previously added
   * Set the `Path mappings`
   * Select `Use Composer Autoloader` and set the `Path to script` to your vendor autoload.php file in the container, i.e. `/var/www/html/vendor/autoload.php`
   * Set the default configuration file to the one in your project, with the container path, i.e. `/var/www/html/phpunit.xml.dist`
1. Run your tests
