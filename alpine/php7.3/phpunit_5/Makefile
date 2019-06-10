-include env_make

PHP_VER ?= 7.3
PHPUNIT_VER ?= 5.7.27
XDEBUG_VER ?= 2.7.2


PHPUNIT_MINOR_VER ?= $(shell echo "${PHPUNIT_VER}" | grep -oE '^[0-9]+\.[0-9]+')
TAG ?= php$(PHP_VER)-phpunit$(PHPUNIT_MINOR_VER)

REPO = walkero/phpunit-alpine
NAME = $(TAG)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build --no-cache -t $(REPO):$(TAG) 	\
			--build-arg PHP_VER=$(PHP_VER) 		\
			--build-arg PHPUNIT_VER=$(PHPUNIT_VER) \
			--build-arg XDEBUG_VER=$(XDEBUG_VER) ./

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
