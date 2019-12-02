export TOP_BUILDDIR=$(CURDIR)
export WIND_USR_MK=$(TOP_BUILDDIR)/mk/usr

include $(WIND_USR_MK)/defs.common.mk
include $(WIND_USR_MK)/defs.packages.mk
include $(WIND_USR_MK)/defs.crossbuild.mk

DEFAULT_BUILD = asio tinyxml2 unixextra ros2 turtlebot3

## Add missing variablse from SDK
export TOOL=llvm
export TGT_ARCH=x86_64
export CMAKE_MODULE_PATH=$(CMAKE_MODULE_DIR)
## XX

.PHONY: clean_buildstamps

all: $(DOWNLOADS_DIR) $(STAMP_DIR) $(EXPORT_DIR)
	for p in $(DEFAULT_BUILD); do $(MAKE) -C pkg/$$p $$p.install; done;

$(EXPORT_DIR):
	@mkdir -p $(EXPORT_DIR)

$(DOWNLOADS_DIR):
	@mkdir -p $(DOWNLOADS_DIR)

$(STAMP_DIR):
	@mkdir -p $(STAMP_DIR)

clean_buildstamps:
	@rm -f $(TOP_BUILDDIR)/build/.stamp/*

distclean:
	@rm -rf $(DOWNLOADS_DIR)
	@rm -rf $(TOP_BUILDDIR)/build

clean: clean_buildstamps

info:
	@$(ECHO) "PACKAGES: $(PACKAGES)"
	@$(ECHO) "CURDIR: $(CURDIR)"
	@$(ECHO) "DOWNLOADS_DIR: $(DOWNLOADS_DIR)"
	@$(ECHO) "PACKAGE_DIR: $(PACKAGE_DIR)"
	@$(ECHO) "BUILD_DIR: $(BUILD_DIR)"
	@$(ECHO) "EXPORT_DIR: $(EXPORT_DIR)"
	@$(ECHO) "ROOT_DIR: $(ROOT_DIR)"
	@$(ECHO) "CMAKE_MODULE_DIR: $(CMAKE_MODULE_DIR)"


