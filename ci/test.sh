xcodebuild\
  -project "$TRAVIS_BUILD_DIR/TableControlling.xcodeproj"\
  -scheme TableControlling\
  -destination 'platform=iOS Simulator,name=iPhone 7,OS=10.0'\
  test
