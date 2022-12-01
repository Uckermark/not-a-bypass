mv not-a-bypass not-a-bypass-bak
mkdir not-a-bypass
mkdir not-a-bypass/Applications
mkdir not-a-bypass/DEBIAN
cp control-nightly not-a-bypass/DEBIAN/control
cp -r 'Payload/Not a bypass.app/' 'not-a-bypass/Applications/Not a bypass.app'
dpkg-deb -b not-a-bypass
rm -rf not-a-bypass
mv not-a-bypass-bak not-a-bypass
echo 'success!'
