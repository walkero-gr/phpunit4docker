# phpunit4docker
**phpunit4docker** is a banch of stand alone docker containers, based on the principle of single logical services per container. These containers can be used from IDEs, like Visual Studio Code and PHPStorm, giving you the ability to experiment with different versions and not rely on the PHPUnit version that exists under vendors folder inside your project.

All the docker images are based on Alpine Linux and have really small footprint, requiring less than 45MB of space.

### Features
- These containers stay alive all the time, as soon as you run them
- Easy usable with docker compose and different project installations
- Are based on the principle of single logical services per container
- Cover different versions of PHP and PHPUnit
- Build from official PHP docker images


## Usage
### Available tags

Find the latest tags at [Docker Hub](https://hub.docker.com/r/walkero/phpunit-alpine/tags)

Coverage generation is available for the tags that include xDebug.

| Tag                  | PHP    | PHPUnit  | xDebug   |
| -------------------- | ------ | -------- | -------- | 
| php7.3-phpunit7.5    | 7.3    | 8.0.x    | 2.7.0    |
| php7.3-phpunit7.5    | 7.3    | 7.5.x    | 2.7.0    |
| php7.3-phpunit6.5    | 7.3    | 6.5.x    | 2.7.0    |
| php7.3-phpunit5.7    | 7.3    | 5.7.x    | 2.7.0    |
| php7.3-phpunit7.5    | 7.2    | 8.0.x    | 2.6.1    |
| php7.2-phpunit7.5    | 7.2    | 7.5.x    | 2.6.1    |
| php7.2-phpunit6.5    | 7.2    | 6.5.x    | 2.6.1    |
| php7.2-phpunit5.7    | 7.2    | 5.7.x    | 2.6.1    |
| php7.1-phpunit7.5    | 7.1    | 7.5.x    |
| php7.1-phpunit6.5    | 7.1    | 6.5.x    |
| php7.1-phpunit5.7    | 7.1    | 5.7.x    |
| php5.6-phpunit5.7    | 5.6    | 5.7.x    |

### Docker Compose
To use these images at your docker-compose yml files, you have to add the following under services:
```yaml
  phpunit:
    image: walkero/phpunit-alpine:php7.3-phpunit7.5
    container_name: "projectname_blackfire"
    volumes:
      - ./public_html:/var/www/html 
```

## VIsual Studio Code

TODO: Add info on VSCode setup with Better PHPUnit extension

## PHPStorm

TODO: Add info on PHPStrom setup
