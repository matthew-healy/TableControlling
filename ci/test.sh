xcodebuild\
  -project "$TRAVIS_BUILD_DIR/TableControlling.xcodeproj"\
  -scheme TableControlling\
  -destination 'platform=iOS Simulator,name=iPhone 7,OS=10.0'\
  CODE_SIGNING_IDENTITY=""\
  CODE_SIGNING_REQUIRED=NO\
  test
