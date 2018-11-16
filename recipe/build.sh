# Turn the work-folder into GOPATH
export GOPATH=${SRC_DIR}
export PATH=${GOPATH}/bin:$PATH
pushd src/github.com/hashicorp/${PKG_NAME}

# Git Initialize
# Apps tend to use git info to create version strings
git init
git config --local user.email "conda@conda-forge.github.io"
git config --local user.name "conda-forge"

echo $PKG_VERSION >> .conda_version
git add .conda_version
git commit -m "conda build of $PKG_NAME-v$PKG_VERSION"
git tag v${PKG_VERSION}

# Build
export CONSUL_DEV=1
make

# Install Binary into PREFIX/bin
mkdir -p $PREFIX/bin
mv $GOPATH/bin/$PKG_NAME $PREFIX/bin/${PKG_NAME}
