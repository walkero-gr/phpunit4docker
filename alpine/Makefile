
# make build UNIT=9 PHP_VER=7.4
-include phpunit.mk

PHP_VER := 7.4
XDEBUG_VER := 2.9.5

PHPUNIT_MINOR_VER := $(shell echo "${PHPUNIT_VER}" | grep -oE '^[0-9]+\.[0-9]+')
PHPUNIT_MAJOR_VER := $(shell echo "${PHPUNIT_VER}" | grep -oE '^[0-9]+')
TAG := php$(PHP_VER)-phpunit$(PHPUNIT_MINOR_VER)
TAG_MAJOR := php$(PHP_VER)-phpunit$(PHPUNIT_MAJOR_VER)

REPO = walkero/phpunit-alpine
NAME = $(TAG)

.PHONY: build buildnc buildmajor push shell start stop logs clean release

default: build

build:
	$(info   Building phpunit image with tag $(TAG))
	docker build -t $(REPO):$(TAG)  \
			--build-arg PHP_VER=$(PHP_VER)  \
			--build-arg PHPUNIT_VER=$(PHPUNIT_VER) \
			--build-arg XDEBUG_VER=$(XDEBUG_VER) ./

buildnc:
	docker build --no-cache -t $(REPO):$(TAG)   \
			--build-arg PHP_VER=$(PHP_VER)  \
			--build-arg PHPUNIT_VER=$(PHPUNIT_VER) \
			--build-arg XDEBUG_VER=$(XDEBUG_VER) ./

buildmajor:
	docker build --no-cache -t $(REPO):$(TAG_MAJOR) \
			--build-arg PHP_VER=$(PHP_VER)  \
			--build-arg PHPUNIT_VER=$(PHPUNIT_VER) \
			--build-arg XDEBUG_VER=$(XDEBUG_VER) ./

push:
	docker push $(REPO):$(TAG)
	docker push $(REPO):$(TAG_MAJOR)

shell:
	docker run --rm --name $(NAME) -it $(REPO):$(TAG) /bin/bash

start:
	docker run -d --name $(NAME) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: buildnc buildmajor push
