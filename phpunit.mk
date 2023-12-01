PHPUNIT_VER := 8.5.35
ifneq ($(origin UNIT),undefined)
	ifeq ($(UNIT),10)
		PHPUNIT_VER := 10.5.0
	endif
	ifeq ($(UNIT),9)
		PHPUNIT_VER := 9.6.14
	endif
	ifeq ($(UNIT),8)
		PHPUNIT_VER := 8.5.35
	endif
	ifeq ($(UNIT),7)
		PHPUNIT_VER := 7.5.20
	endif
	ifeq ($(UNIT),6)
		PHPUNIT_VER := 6.5.14
	endif
	ifeq ($(UNIT),5)
		PHPUNIT_VER := 5.7.27
	endif
endif
