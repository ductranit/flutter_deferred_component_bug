# deferred_components_bug
This repo uses to reproduce flutter deferred component load [asset issue](https://github.com/flutter/flutter/issues/86923)
## Here are the steps:
- Build a release with `flutter build appbundle`
- Install the buid into device by using [bundletool](https://developer.android.com/studio/command-line/bundletool)
```
java -jar bundletool.jar build-apks --bundle=/flutter_deferred_component_bug/build/app/outputs/bundle/release/app-release.aab --output=/flutter_deferred_component_bug/build/app/outputs/bundle/release/app.apks --local-testing

java -jar bundletool.jar install-apks --apks=/flutter_deferred_component_bug/build/app/outputs/bundle/release/app.apks
```
- Launch the app on device
- Click on `install book component` button and wait for it loads
- Click on `load book deferred asset` to show book image. It works normally
- Click on `navigate to other screen` to show a webview screen
- Click on `push new stack`
- Click on `install cover component` button to install another component
- Click on `load cover deferred asset` to show cover image. And there is an error in this step - the image can't be loaded (it works on debug)