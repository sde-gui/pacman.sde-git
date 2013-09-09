
P = repo/.timestamp.

ALL_PACKAGES = \
	$(P)sde-meta-git \
	$(P)sde-reverse-meta-git \
	$(P)libsde-utils-gtk2-git \
	$(P)libsde-utils-jansson-git \
	$(P)libsmfm-core-git \
	$(P)libsmfm-gtk2-git \
	$(P)stuurman-git \
	$(P)stuurman-desktop-git \
	$(P)waterline-git


all: repo/sde.db.tar.gz

repo/sde.db.tar.gz: packages
	rm -f repo/sde.db.tar.gz && repo-add -f repo/sde.db.tar.gz repo/*.xz

packages: $(ALL_PACKAGES)

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

repo/.timestamp.%:
	./build_package.sh $*


