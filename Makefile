NDK_HOME=/home/olpc/ext4/android-ndk-r10b
ARCH=arch-arm

TARGET=$(ARCH).$(TOOLCHAIN).$(PLATFORM)
TOOLCHAINDIR=$(wildcard $(NDK_HOME)/toolchains/$(TOOLCHAIN)/prebuilt/*)
PLATFORMDIR=$(NDK_HOME)/platforms/$(PLATFORM)/$(ARCH)

list:
	@echo symlink these files into a subfolder of your project, then
	@echo make prep \\
	@echo   TOOLCHAIN=\<$$(cd $(NDK_HOME)/toolchains; echo *|tr " " "|")\> \\
	@echo   ARCH='[arch-]<arm|mips|x86>' \\
	@echo   PLATFORM=\<$$(cd $(NDK_HOME)/platforms; echo *|tr " " "|")\>

prep: $(TARGET)/configure


$(TARGET)/configure: $(TOOLCHAINDIR)/bin $(PLATFORMDIR)/usr
	mkdir -p $(TARGET)
	ln -sf $(TOOLCHAINDIR) $(TARGET)/toolchain
	ln -sf $(PLATFORMDIR) $(TARGET)/platform
	cd $(TARGET); ln -sf platform/usr/lib/*.o .
	echo '#!/bin/sh' > $@
	echo '. ../configure.template' >> $@ || rm $@
	chmod 755 $@

clean:
	rm -vrf *-*.*.*.*
