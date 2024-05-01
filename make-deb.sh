#!/bin/bash

# Make Deb Package for Srsu (^.^)
_PACKAGE=srsu
_VERSION=1.0
_ARCH="all"
PKG_NAME="${_PACKAGE}_${_VERSION}_${_ARCH}.deb"

if [[ ! -e "scripts/launch.sh" ]]; then
        echo "lauch.sh should be in the \`scripts\` Directory. Exiting..."
        exit 1
fi

if [[ ${1,,} == "termux" || $(uname -o) == *'Android'* ]];then
        _depend="ncurses-utils, proot, resolv-conf, "
        _bin_dir="/data/data/com.termux/files/"
        _opt_dir="/data/data/com.termux/files/usr/"
        #PKG_NAME=${_PACKAGE}_${_VERSION}_${_ARCH}_termux.deb
fi

_depend+="curl, php, unzip"
_bin_dir+="usr/bin"
_opt_dir+="opt/${_PACKAGE}"

if [[ -d "ultra303" ]]; then rm -fr ultra303; fi
mkdir -p ultra303
mkdir -p ultra303/${_bin_dir} ultra303/$_opt_dir ultra303/DEBIAN 

cat <<- CONTROL_EOF > ultra303/DEBIAN/control
Package: ${_PACKAGE}
Version: ${_VERSION}
Architecture: ${_ARCH}
Maintainer: @ultra303
Depends: ${_depend}
Homepage: https://github.com/ultra303/srsu
Description: An automated phishing tool with 5 templates and this Tool is made for educational purpose only !
CONTROL_EOF

cat <<- PRERM_EOF > ultra303/DEBIAN/prerm
#!/bin/bash
rm -fr $_opt_dir
exit 0
PRERM_EOF

chmod 755 ultra303/DEBIAN
chmod 755 ultra303/DEBIAN/{control,prerm}
cp -fr scripts/launch.sh ultra303/$_bin_dir/$_PACKAGE
chmod 755 ultra303/$_bin_dir/$_PACKAGE
cp -fr .github/ .sites/ LICENSE README.md srsu.sh ultra303/$_opt_dir
dpkg-deb --build ultra303${PKG_NAME}
rm -fr ultra303



