
all: repo/sde-nightly.db.tar.gz

P = repo/.timestamp.build.

include tmp/Makefile.deps

PACKAGE_TARGETS=$(addprefix $(P),$(PACKAGES))

repo/sde-nightly.db.tar.gz: packages
	rm -f repo/sde-nightly.db.tar.gz && repo-add repo/sde-nightly.db.tar.gz repo/*.xz

packages: $(PACKAGE_TARGETS)

repo/.timestamp.build.%:
	./build_package.sh $*

tmp/Makefile.deps: $(shell ls recipes/*/PKGBUILD)
	./gen_deps.sh > tmp/Makefile.deps.tmp && mv tmp/Makefile.deps.tmp tmp/Makefile.deps || rm tmp/Makefile.deps

