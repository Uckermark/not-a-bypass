mkdir not-a-bypass-nightly not-a-bypass-nightly/DEBIAN not-a-bypass-nightly/Applications
cp control-nightly not-a-bypass-nightly/DEBIAN/control
cp -r 'Payload/Not a bypass.app/' 'not-a-bypass-nightly/Applications/Not a bypass.app'
dpkg-deb -b not-a-bypass-nightly >> /dev/null
rm -rf not-a-bypass-nightly
echo 'written output to not-a-bypass-nightly.deb'

