# SquircleView

Apple flavored curvature continuity for React Native

## Getting started

```bash
yarn add react-native-super-ellipse-mask
```

### Mostly automatic installation

`$ react-native link react-native-squircle-view`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` > `Add Files to [your project's name]`
2. Go to `node_modules` > `react-native-squircle-view` and add `RNSquircleView.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSquircleView.a` to your project's `Build Phases` > `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

## Usage

```javascript
<SquircleView style={styles.whatever} interpolatePath={true}>
  ...
</SquircleView>
```

## Caveats

If XCode gives you a linker error and many warnings like `Auto-Linking library not found for -lswiftCoreGraphics` just add an [empty swift file](/examples/basic/ios/basic/workaround.swift) to the root of your `.xcodeproj` ([Source](https://stackoverflow.com/questions/50096025/it-gives-errors-when-using-swift-static-library-with-objective-c-project/50495316#50495316))

## Known Issues

- **Non compliant CSS borders**: Currently this library doesn't support CSS compliant borders (like React Native's `<View/>` does).
- **Limited corner radius**: The maximum corner radius for each corner can't be greater than half of the smallest side of the view.

<!-- XCode 10 solution
cd node_modules/react-native/scripts ;and ./ios-install-third-party.sh ;and cd ../../../
cd node_modules/react-native/third-party/glog-0.3.5/ ;and ../../scripts/ios-configure-glog.sh ;and cd ../../../../
react-native start --reset-cache
-->
