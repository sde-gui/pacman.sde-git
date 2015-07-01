
all: repo/sde-nightly.db.tar.gz

P  = repo/.timestamp.build.

PACKAGES = \
	sde-meta-git \
	sde-reverse-meta-git \
	libsde-utils-git \
	libsde-utils-x11-git \
	libsde-utils-gtk2-git \
	libsde-utils-jansson-git \
	libsmfm-core-git \
	libsmfm-gtk2-git \
	stuurman-git \
	stuurman-desktop-git \
	waterline-git \
	waterline-plugin-multiload-git \
	spicview-git


PACKAGE_TARGETS=$(addprefix $(P),$(PACKAGES))

repo/sde-nightly.db.tar.gz: packages
	rm -f repo/sde-nightly.db.tar.gz && repo-add -f repo/sde-nightly.db.tar.gz repo/*.xz

packages: $(PACKAGE_TARGETS)

$(P)libsde-utils-git: $(P)sde-reverse-meta-git
$(P)libsde-utils-x11-git: $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)libsde-utils-gtk2-git: $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)libsde-utils-jansson-git: $(P)libsde-utils-gtk2-git $(P)libsde-utils-git $(P)sde-reverse-meta-git
$(P)libsmfm-core-git: $(P)sde-reverse-meta-git
$(P)libsmfm-gtk2-git: $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)stuurman-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)stuurman-desktop-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git $(P)sde-reverse-meta-git
$(P)waterline-git: $(P)libsde-utils-jansson-git $(P)libsde-utils-gtk2-git $(P)libsde-utils-git $(P)libsde-utils-x11-git $(P)sde-reverse-meta-git
$(P)waterline-plugin-multiload-git: $(P)waterline-git
$(P)spicview-git: $(P)libsmfm-gtk2-git $(P)sde-reverse-meta-git
$(P)sde-meta-git: $(P)stuurman-git $(P)stuurman-desktop-git $(P)waterline-git $(P)spicview-git
$(P)sde-reverse-meta-git:

repo/.timestamp.build.%:
	./build_package.sh $*

