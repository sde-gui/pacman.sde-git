
P = ready/.timestamp.

ALL_PACKAGES = \
	$(P)sde-meta-git \
	$(P)libsde-utils-gtk2-git \
	$(P)libsde-utils-jansson-git \
	$(P)libsmfm-core-git \
	$(P)libsmfm-gtk2-git \
	$(P)stuurman-git \
	$(P)stuurman-desktop-git \
	$(P)waterline-git


all: ready/sde.db.tar.gz

ready/sde.db.tar.gz: packages
	rm -f ready/sde.db.tar.gz && repo-add -f ready/sde.db.tar.gz ready/*.xz

packages: $(ALL_PACKAGES)

$(P)libsde-utils-git:
$(P)libsde-utils-gtk2-git: $(P)libsde-utils-git
$(P)libsde-utils-jansson-git: $(P)libsde-utils-gtk2-git $(P)libsde-utils-git
$(P)libsmfm-core-git:
$(P)libsmfm-gtk2-git: $(P)libsmfm-core-git
$(P)stuurman-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git
$(P)stuurman-desktop-git: $(P)libsmfm-gtk2-git $(P)libsmfm-core-git
$(P)waterline-git: $(P)libsmfm-gtk2-git $(P)libsde-utils-jansson-git $(P)libsde-utils-gtk2-git $(P)libsde-utils-git
$(P)sde-meta-git: $(P)stuurman-git $(P)stuurman-desktop-git $(P)waterline-git

ready/.timestamp.%:
	./build_package.sh $*


