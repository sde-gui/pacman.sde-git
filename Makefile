
P  = repo/.timestamp.build.
PP = repo/.timestamp.prepare.

PACKAGES = \
	sde-meta-git \
	sde-reverse-meta-git \
	libsde-utils-gtk2-git \
	libsde-utils-jansson-git \
	libsmfm-core-git \
	libsmfm-gtk2-git \
	stuurman-git \
	stuurman-desktop-git \
	waterline-git


PACKAGE_TARGETS=$(addprefix $(P),$(PACKAGES))

__dummy:=$(foreach p,$(PACKAGES),$(eval $(P)$(p): $(PP)$(p)))

all: repo/sde.db.tar.gz

repo/sde.db.tar.gz: packages
	rm -f repo/sde.db.tar.gz && repo-add -f repo/sde.db.tar.gz repo/*.xz

packages: $(PACKAGE_TARGETS)

$(P)libsde-utils-git: $(P)sde-reverse-meta-git
$(P)libsde-utils-gtk2-git: $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)libsde-utils-jansson-git: $(P)libsde-utils-gtk2-git $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)libsmfm-core-git: $(P)sde-reverse-meta-git
$(P)libsmfm-gtk2-git: $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)stuurman-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)stuurman-desktop-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)waterline-git: $(P)libsmfm-gtk2-git $(P)libsde-utils-jansson-git $(P)libsde-utils-gtk2-git $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)sde-meta-git: $(P)stuurman-git $(P)stuurman-desktop-git $(P)waterline-git
$(P)sde-reverse-meta-git:

repo/.timestamp.build.%:
	./build_package.sh $*

repo/.timestamp.prepare.%:
	./prepare_package.sh $*

