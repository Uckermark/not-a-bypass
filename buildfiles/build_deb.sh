mkdir build build/DEBIAN build/Applications
cp buildfiles/control build/DEBIAN/control
cp -r 'Payload/Not a bypass.app/' 'build/Applications/not-a-bypass.app'
dpkg-deb -b -Zgzip build not-a-bypass.deb
rm -rf build
echo 'written output to not-a-bypass.deb'

