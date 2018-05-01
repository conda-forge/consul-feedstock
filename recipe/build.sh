#!/usr/bin/env bash

# Turn the work-folder into GOPATH
pkg_dir=$(pwd)
cd ..
export GOPATH=$(pwd)
export GOSRC_PREFIX=$GOPATH/src/github.com/hashicorp
export PATH=$GOPATH/bin:$PATH
mkdir -p $GOSRC_PREFIX

mv $pkg_dir $GOSRC_PREFIX/$PKG_NAME
ln -s $GOSRC_PREFIX/$PKG_NAME $pkg_dir
cd $GOSRC_PREFIX/$PKG_NAME

# Git Initialize
# Apps tend to use git info to create version strings
git init
git config --local user.email "conda@conda-forge.github.io"
git config --local user.name "conda-forge"
git add conda_build.sh
git commit -m "conda build of $PKG_NAME-v$PKG_VERSION"
git tag v${PKG_VERSION}

# Build
export CONSUL_DEV=1
make

# Install Binary into PREFIX/bin
mv $GOPATH/bin/$PKG_NAME $PREFIX/bin/${PKG_NAME}
