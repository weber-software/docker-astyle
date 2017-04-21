.PHONY: build

build: bin/astyle

astyle.tar.gz:
	wget -O astyle.tar.gz https://downloads.sourceforge.net/project/astyle/astyle/astyle%203.0/astyle_3.0_linux.tar.gz

astyle: astyle.tar.gz
	tar -xf astyle.tar.gz

astyle/src/Makefile: astyle
	cp astyle/build/gcc/Makefile astyle/src/Makefile

bin:
	mkdir -p bin

bin/astyle: bin astyle/src/Makefile
	LDFLAGS=-static CFLAGS="-Wall -Wextra -fno-rtti -fno-exceptions -std=c++11 -static" cd astyle/src/ && make
	strip astyle/src/bin/astyle
	cp astyle/src/bin/astyle bin