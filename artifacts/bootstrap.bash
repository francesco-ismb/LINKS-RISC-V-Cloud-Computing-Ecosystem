#!/usr/bin/env bash
# Copyright 2015 The Go Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# When run as (for example)
#
#	GOOS=linux GOARCH=ppc64 bootstrap.bash
#
# this script cross-compiles a toolchain for that GOOS/GOARCH
# combination, leaving the resulting tree in ../../go-${GOOS}-${GOARCH}-bootstrap.
# That tree can be copied to a machine of the given target type
# and used as $GOROOT_BOOTSTRAP to bootstrap a local build.
#
# Only changes that have been committed to Git (at least locally,
# not necessary reviewed and submitted to master) are included in the tree.
#
# See also golang.org/x/build/cmd/genbootstrap, which is used
# to generate bootstrap tgz files for builders.

set -e

if [ "$GOOS" = "" -o "$GOARCH" = "" ]; then
	echo "usage: GOOS=os GOARCH=arch ./bootstrap.bash" >&2
	exit 2
fi

targ="../go-${GOOS}-${GOARCH}"
if [ -e $targ ]; then
	echo "$targ already exists; remove before continuing"
	exit 2
fi

unset GOROOT
src=$(cd go && pwd)
echo "#### Copying to $targ"
cp -Rp "$src" "$targ"
cd "$targ"
echo
echo "#### Cleaning $targ"
chmod -R +w .
rm -f .gitignore
if [ -e .git ]; then
	git clean -f -d
fi
echo
echo "#### Building $targ"
echo
cd src
./make.bash --no-banner
gohostos="$(../bin/go env GOHOSTOS)"
gohostarch="$(../bin/go env GOHOSTARCH)"
goos="$(../bin/go env GOOS)"
goarch="$(../bin/go env GOARCH)"

# NOTE: Cannot invoke go command after this point.
# We're about to delete all but the cross-compiled binaries.
cd ..
if [ "$goos" = "$gohostos" -a "$goarch" = "$gohostarch" ]; then
	# cross-compile for local system. nothing to copy.
	# useful if you've bootstrapped yourself but want to
	# prepare a clean toolchain for others.
	true
else
	rm -f bin/go_${goos}_${goarch}_exec
	mv bin/*_*/* bin
	rmdir bin/*_*
	rm -rf "pkg/${gohostos}_${gohostarch}" "pkg/tool/${gohostos}_${gohostarch}"
fi

rm -rf pkg/bootstrap pkg/obj .git

echo ----
echo Bootstrap toolchain for "$GOOS/$GOARCH" installed in "$(pwd)".
echo Building tbz.

cd ..
tar cf - "go-${GOOS}-${GOARCH}" | bzip2 -9 >"go-${GOOS}-${GOARCH}.tbz"
mkdir go-${GOOS}-${GOARCH}/archives/
mv go-${GOOS}-${GOARCH}.tbz go-${GOOS}-${GOARCH}/archives/go-${GOOS}-${GOARCH}.tbz 
ls -l "./go-${GOOS}-${GOARCH}/archives/go-${GOOS}-${GOARCH}.tbz"
exit 0 
