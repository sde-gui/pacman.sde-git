
all: repo/sde-nightly.db.tar.gz

P = repo/.timestamp.build.

include Makefile.deps

PACKAGE_TARGETS=$(addprefix $(P),$(PACKAGES))

repo/sde-nightly.db.tar.gz: packages
	rm -f repo/sde-nightly.db.tar.gz && repo-add -f repo/sde-nightly.db.tar.gz repo/*.xz

packages: $(PACKAGE_TARGETS)

repo/.timestamp.build.%:
	./build_package.sh $*

Makefile.deps: $(shell ls */PKGBUILD)
	./gen_deps.sh > Makefile.deps.tmp && mv Makefile.deps.tmp Makefile.deps || rm Makefile.deps

