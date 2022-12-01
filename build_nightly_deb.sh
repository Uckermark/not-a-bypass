mkdir not-a-bypass-nightly
mkdir not-a-bypass-nightly/Applications
mkdir not-a-bypass-nightly/DEBIAN
cp control-nightly not-a-bypass-nightly/DEBIAN/control
cp -r 'Payload/Not a bypass.app/' 'not-a-bypass-nightly/Applications/Not a bypass.app'
dpkg-deb -b not-a-bypass-nightly
echo 'success!'
