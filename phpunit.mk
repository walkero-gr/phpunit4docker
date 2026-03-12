PHPUNIT_VER := 13.0.5
ifneq ($(origin UNIT),undefined)
	ifeq ($(UNIT),13)
		PHPUNIT_VER := 13.0.5
	endif
	ifeq ($(UNIT),12)
		PHPUNIT_VER := 12.5.14
	endif
	ifeq ($(UNIT),11)
		PHPUNIT_VER := 11.5.55
	endif
	ifeq ($(UNIT),10)
		PHPUNIT_VER := 10.5.63
	endif
	ifeq ($(UNIT),9)
		PHPUNIT_VER := 9.6.34
	endif
	ifeq ($(UNIT),8)
		PHPUNIT_VER := 8.5.52
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
