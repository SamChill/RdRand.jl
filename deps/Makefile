UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
	SLIB = dylib
else
	SLIB = so
endif

librdrand.$(SLIB): rdrand/rdrand.c
	cc -shared -fPIC -O2 rdrand/rdrand.c -o librdrand.$(SLIB) -Irdrand

clean:
	rm librdrand.$(SLIB)
