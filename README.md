[![Build Status](https://drone-gh.intercube.gr/api/badges/walkero-gr/phpunit4docker/status.svg)](https://drone-gh.intercube.gr/walkero-gr/phpunit4docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/walkero/phpunit-alpine?color=brightgreen)](https://hub.docker.com/r/walkero/phpunit-alpine)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/db9d7c92f8694ecda2f1cd314fd03969)](https://www.codacy.com/gh/walkero-gr/phpunit4docker/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=walkero-gr/phpunit4docker&amp;utm_campaign=Badge_Grade)
[![github](https://img.shields.io/badge/Repo%20on%20GitHub-100000?style=flat&logo=github&logoColor=white)](https://github.com/walkero-gr/phpunit4docker)
[![ko-fi](https://img.shields.io/badge/Buy%20me%20a%20Ko--fi-F16061?style=flat&logo=ko-fi&logoColor=white)](https://ko-fi.com/walkero)

# phpunit4docker

**phpunit4docker** is a bunch of stand-alone Docker containers, based on the principle of single logical services per container. These containers can be used from IDEs, like Visual Studio Code and PHPStorm, giving you the ability to experiment with different versions and not rely on the PHPUnit version that exists under the **.vendors** folder inside your project.

All the docker images are based on Alpine Linux and have a really small footprint, requiring less than 45MB of space.

## Features

- These containers stay alive all the time, as soon as you run them
- Easy usable with docker-compose and multiple project installations
- Are based on the principle of single logical services per container
- Cover different versions of PHP and PHPUnit
- Build from official PHP docker images
- PHPUnit is able to generate coverage reports
- Supports PDO MySQL

## Usage

### Available tags

All images are built for **AMD64** and **ARM64** platforms, so they can be used in any Intel/AMD CPU based computers, in Mac M1 and other ARM CPU based computers.

All the images have **xDebug v3.1.2** installed.

**phpunit9:** php8.1-phpunit9, php8.0-phpunit9, php7.4-phpunit9, php7.3-phpunit9

**phpunit8:** php8.1-phpunit8, php8.0-phpunit8, php7.4-phpunit8, php7.3-phpunit8, php7.2-phpunit8

**phpunit7:** php7.3-phpunit7, php7.2-phpunit7, php7.1-phpunit7

**phpunit6:** php7.2-phpunit6, php7.1-phpunit6

**phpunit5:** php7.1-phpunit5, php5.6-phpunit5

Aligned release based on PHPUnit [Supported Versions](https://phpunit.de/supported-versions.html)

Find the latest tags at [Docker Hub](https://hub.docker.com/r/walkero/phpunit-alpine/tags)

### Docker Compose

To use these images at your docker-compose yml files, you have to add the following under services:

```yaml
  phpunit:
    image: walkero/phpunit-alpine:php7.3-phpunit8
    container_name: "projectname_phpunit"
    environment:
      XDEBUG_MODE: 'coverage'
    volumes:
      - ./public_html:/var/www/html
```

### Visual Studio Code

I recommend using the [Better PHPUnit](https://github.com/calebporzio/better-phpunit) extension.

Add the following settings in your project `settings.json` file.

```json
{
    "better-phpunit.docker.enable": true,
    "better-phpunit.docker.command": "docker exec -it <container name>",
    "better-phpunit.docker.paths": {
        "<your local public_html files path>": "/var/www/html"
    },
    "better-phpunit.phpunitBinary": "phpunit",
    "better-phpunit.xmlConfigFilepath": "/var/www/html/phpunit.xml",
    "better-phpunit.coveragePath": "test/coverage",
    "better-phpunit.coverageFormat": "HTML",
}
```

Consult the extension's documentation about the key combinations or the menu selections you can use to run your tests.

### PHPStorm

  1. First, we have to configure the connection to the Docker engine:
    - Go to `Preferences -> Build, Execution, Deployment -> Docker`
    - Create a new Docker configuration:
      - for MacOS select `Docker for Mac`
      - For Linux and Windows, select the `TCP socket`. Set the `Engine API URL` to:
        - Linux: `unix:///var/run/docker.sock`
        - Windows: `http://127.0.0.1:2376` or `tcp://localhost:2376`
  2. Next, we must configure the remote interpreter:
    - Go to `Preferences -> Languages & Frameworks -> PHP`
    - Create a new PHP CLI interpreter by:
      - Clicking on **...** then **+** and select `From Docker, Vagrant, VM, Remote...`
      - At the radio buttons select `Docker Compose` with the following values:
        - Server: **Docker**
        - Configuration file(s): [select here the project docker-compose.yml file]
        - Service: **phpunit**
      - Click on the `OK` button
      - Now the phpunit docker is added to your CLI Interpreters list at the left. At the right, there are the configuration options. Change:
        - Lifecycle to `Connect to the existing container ('docker-compose exec')` as these containers run always
      - Click on the `OK` button
  3. Time to configure the PHPUnit in the project:
    - Go to `Preferences -> Languages & Frameworks -> PHP -> Test Frameworks`
    - Create a new PHPUnit configuration by clicking the **+** and selecting `PHPUnit by Remote interpreter...`
    - Select from the list the phpunit previously added
    - Set the `Path mappings`
    - Select `Use Composer Autoloader` and set the `Path to script` to your vendor autoload.php file in the container, i.e. `/var/www/html/vendor/autoload.php`
    - Set the default configuration file to the one in your project, with the container path, i.e. `/var/www/html/phpunit.xml.dist`
  4. Run your tests
