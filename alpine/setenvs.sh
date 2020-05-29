#!/bin/bash

while getopts u:p: option
do
	case "${option}" in
		u) UNIT=${OPTARG};;
		p) PHP_VER=${OPTARG};;
	esac
done

case "${UNIT}" in
	5)
		PHPUNIT_VER="5.7.27"
		;;
	6)
		PHPUNIT_VER="6.5.14"
		;;
	7)
		PHPUNIT_VER="7.5.19"
		;;
	8)
		PHPUNIT_VER="8.5.5"
		;;
	*)
		PHPUNIT_VER="9.1.5"
		;;
esac

export PHPUNIT_VER=${PHPUNIT_VER}
export PHP_VER=${PHP_VER}
