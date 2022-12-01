TARGET_CODESIGN = $(shell which ldid)

WRTMP = $(TMPDIR)/bypass
WR_STAGE_DIR = $(WRTMP)/stage
WR_APP_DIR = $(WRTMP)"/Build/Products/Release-iphoneos/Not a bypass.app"
package:
	@./getsubstitute.sh

	@set -o pipefail; \
		xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'not-a-bypass.xcodeproj' -scheme not-a-bypass -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath $(WRTMP) \
		CODE_SIGNING_ALLOWED=NO DSTROOT=$(WRTMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
		
	@rm -rf Payload
	@rm -rf $(WR_STAGE_DIR)/
	@mkdir -p $(WR_STAGE_DIR)/Payload
	@mv $(WR_APP_DIR) "$(WR_STAGE_DIR)/Payload/Not a bypass.app"

	@echo $(WRTMP)
	@echo $(WR_STAGE_DIR)

	@ls $(WR_HELPER_PATH)
	@ls $(WR_STAGE_DIR)
	@$(TARGET_CODESIGN) -Sentitlements.xml "$(WR_STAGE_DIR)/Payload/Not a bypass.app/"
	
	@rm -rf "$(WR_STAGE_DIR)/Payload/Not a bypass.app/_CodeSignature"

	@ln -sf $(WR_STAGE_DIR)/Payload Payload

	@rm -rf packages
	@mkdir -p packages

	@zip -r9 "packages/Not a bypass.ipa" Payload
	@rm -rf Payload
