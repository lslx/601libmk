#
#
#make custom lib , rom
#
#

srcroot=/home/fhc/ext800/src-android-local/android-6.0.1_r77

#VPATH=$(dvmsrcpath)
vpath %.so $(srcroot)/out/target/product/hammerhead/system/lib
vpath %.cc $(srcroot)/art/runtime
vpath %.h  $(srcroot)/art/runtime

libart_t.so:libart.so
	cp $(srcroot)/out/target/product/hammerhead/system/lib/libart.so libart_t.so

libart.so:class_linker.cc dex_file.cc dex_file.h
	 androot=$(srcroot) ./buildart.sh
class_linker.cc:u_class_linker.cc
	cp u_class_linker.cc $(srcroot)/art/runtime/class_linker.cc
dex_file.cc:u_dex_file.cc
	cp u_dex_file.cc $(srcroot)/art/runtime/dex_file.cc
dex_file.h:u_dex_file.h
	cp u_dex_file.h $(srcroot)/art/runtime/dex_file.h

clean:
	rm $(srcroot)/out/target/product/hammerhead/system/lib/libart.so libart_t.so

install:
	adb push libart_t.so /data/local/tmp/
	adb shell su -c mount -o rw,remount /system
	adb shell su -c cp /data/local/tmp/libart_t.so /system/lib/libart.so
	adb shell su -c mount -o ro,remount /system
uninstall:
	adb push libart.so /data/local/tmp/
	adb shell su -c mount -o rw,remount /system
	adb shell su -c cp /data/local/tmp/libart.so /system/lib/libart.so
	adb shell su -c mount -o ro,remount /system
