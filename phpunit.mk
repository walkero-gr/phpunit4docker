PHPUNIT_VER := 8.5.5
ifneq ($(origin UNIT),undefined)
	ifeq ($(UNIT),10)
		PHPUNIT_VER := 10.2.1
	endif
	ifeq ($(UNIT),9)
		PHPUNIT_VER := 9.6.8
	endif
	ifeq ($(UNIT),8)
		PHPUNIT_VER := 8.5.33
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
