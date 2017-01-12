# SDE build scripts for Arch Linux

These scripts build and install the development version of SDE from the bleeding-edge sources. Just clone the repo and run `make`:

```
    $ git clone https://github.com/sde-gui/pacman.sde-git.git
    $ cd pacman.sde-git
    $ make
```

The build script will read package dependencies from PKGBUILD files and then compile and install the packages in the correct order.

You can specify the `-j` option to enable the parallel build:

```sh
    $ make -j2 # enable two parallel builds
    $ make -j  # enable maximum parallelization
```

The following environment variables can be used to override the default commands:

```sh
    $ export PACMAN="your-pacman-command --with-some-arguments"
    $ export MAKEPKG="your-makepkg-command --with-some-arguments"
    $ export SUDO="your-command-to-acquire-root-privileges"
```

To update SDE, run:

```sh
    $ git clean -dfx # erase all generated files
    $ git pull # sync your copy of pacman.sde-git with the upstream
    $ make # rebuild all packages
```

It is not recommended to update the development version of SDE partially, since the development version has unstable API that can break things at any time.
