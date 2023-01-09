NCODESIGN = $(shell which ldid)

NTMP = $(TMPDIR)/bypass
NSTAGE_DIR = $(NTMP)/stage
NAPP_DIR = $(NTMP)"/Build/Products/Release-iphoneos/Not a bypass.app"

package:
	@./buildfiles/getsubstitute.sh

	@set -o pipefail; \
		xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'not-a-bypass.xcodeproj' -scheme not-a-bypass -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath $(NTMP) \
		CODE_SIGNING_ALLOWED=NO DSTROOT=$(NTMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
		
	@rm -rf Payload
	@rm -rf $(NSTAGE_DIR)/
	@mkdir -p $(NSTAGE_DIR)/Payload
	@mv $(NAPP_DIR) "$(NSTAGE_DIR)/Payload/not-a-bypass.app"

	@$(NCODESIGN) -Sbuildfiles/entitlements.xml $(NSTAGE_DIR)/Payload/not-a-bypass.app/
	
	@rm -rf "$(NSTAGE_DIR)/Payload/not-a-bypass.app/_CodeSignature"

	@ln -sf $(NSTAGE_DIR)/Payload Payload

	@rm -rf packages
	@mkdir -p packages

	@zip -r9 "packages/not-a-bypass.ipa" Payload
	
	@mkdir -p deb/ deb/Applications/
	@cp -r buildfiles/DEBIAN/ deb/DEBIAN
	@cp -r Payload/not-a-bypass.app/ deb/Applications/not-a-bypass.app
	@dpkg-deb -b -Zgzip deb/ packages/not-a-bypass.deb
	@rm -rf deb
