# Find the sim UDID for an iPhone 7 on iOS 10.0
export SIMULATOR_UDID=`python $TRAVIS_BUILD_DIR/ci/get_sim_id.py \
  --osversion "iOS 10.0"`

# Let the user know if we couldn't get the UDID
: "${SIMULATOR_UDID:?Failed to set SIMULATOR_UDID}"

# Boot the sim
xcrun simctl boot "${SIMULATOR_UDID}"

# Wait for the sim to boot...
sleep 10

# Run the tests
set -o pipefail && \
env NSUnbufferedIO=YES \
env RUN_CLANG_STATIC_ANALYZER=NO \
env OBJC_DISABLE_GC=YES \
xcodebuild \
  -project "$TRAVIS_BUILD_DIR/TableControlling.xcodeproj" \
  -scheme TableControlling \
  -destination "platform=iOS Simulator,id=${SIMULATOR_UDID}" \
  CODE_SIGNING_IDENTITY=""\
  CODE_SIGNING_REQUIRED=NO\
  test
