CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

ALL:
	$(CC) --sysroot $(SYSROOT) -c ./libmincrypt/*.c -I./include
	$(AR) rcs ./libmincrypt/libmincrypt.a *.o
	$(CC) --sysroot $(SYSROOT) mkbootimg/mkbootimg.c -o mkbootimg/mkbootimg -I./include ./libmincrypt/libmincrypt.a -static
	$(CC) --sysroot $(SYSROOT) mkbootimg/unpackbootimg.c -o mkbootimg/unpackbootimg -I./include ./libmincrypt/libmincrypt.a -static

clean:
	rm -rf libmincrypt/*.o mkbootimg/*.o cpio/*.o *.o
	rm -rf libmincrypt/libmincrypt.a mkbootimg/mkbootimg mkbootimg/unpackbootimg
