##Building
export CROSS_COMPILE=\<path\> (for ARM)  
export SYSROOT=\<path\> (for ARM)  
make  

##Clean
make clean  

##Installing on Android
adb push ./out/mkbootimg /data/local/tmp/  
adb push ./out/unpackbootimg /data/local/tmp/  
adb shell  
chmod 0755 /data/local/tmp/mkbootimg  
chmod 0755 /data/local/tmp/unpackbootimg  
./data/local/tmp/mkbootimg  
./data/local/tmp/unpackbootimg  
