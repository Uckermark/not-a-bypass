if [ ! -f not-a-bypass/Required/substitute.deb ]; then
    curl -sLO https://cdn.discordapp.com/attachments/688126487588634630/1026673680387936256/com.ex.substitute_2.3.1_iphoneos-arm.deb
    mv com.ex.substitute_2.3.1_iphoneos-arm.deb not-a-bypass/Required/substitute.deb
fi
