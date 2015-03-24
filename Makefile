CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

ifneq ($(SYSROOT),)
	CFLAGS += --sysroot $(SYSROOT)
endif

all:
	@mkdir -p ./out
	@$(CC) $(CFLAGS) -c ./libmincrypt/rsa.c -I./include -o ./out/rsa.o
	@$(CC) $(CFLAGS) -c ./libmincrypt/sha256.c -I./include -o ./out/sha256.o
	@$(CC) $(CFLAGS) -c ./libmincrypt/sha.c -I./include -o ./out/sha.o
	@$(AR) rcs ./out/libmincrypt.a out/rsa.o out/sha256.o ./out/sha.o
	@$(CC) $(CFLAGS) ./mkbootimg/mkbootimg.c -o ./out/mkbootimg \
		-I./include ./out/libmincrypt.a -static && \
		echo ./out/mkbootimg
	@$(CC) $(CFLAGS) ./mkbootimg/unpackbootimg.c -o ./out/unpackbootimg \
		-I./include ./out/libmincrypt.a -static && \
		echo ./out/unpackbootimg

clean:
	-@rm ./out/libmincrypt.a ./out/rsa.o ./out/sha256.o ./out/sha.o \
		./out/mkbootimg ./out/unpackbootimg 2>/dev/null || true
	-@rmdir ./out 2>/dev/null || true
