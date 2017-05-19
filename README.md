# react-native-unified-push

RNUnifiedPush simplifies the usage of Unified Push Server (https://aerogear.org/push/) in React Native apps. It enables an app to subscribe and receive Push Notifications sent from any Unified Push Server.

## Getting started

`$ npm install react-native-unified-push --save`

### Linking the library

`$ react-native link react-native-unified-push`

### Configure on Android

1. Add the following lines to `android/build.gradle` inside `dependencies`:
    classpath 'com.google.gms:google-services:3.0.0'
    classpath 'com.diffplug.spotless:spotless-plugin-gradle:3.3.0'

2. Add the following lines to `android/app/build.gradle` inside `dependencies`:
    compile 'org.jboss.aerogear:aerogear-android-core:3.0.0'
    compile 'org.jboss.aerogear:aerogear-android-pipe:3.0.0'
    compile 'org.jboss.aerogear:aerogear-android-push:4.0.1'

3. Append the following line to `android/app/build.gradle`:
    apply plugin: 'com.google.gms.google-services'

4. Add your google-services.json file to `android/app/` (how to get your google-services.json: https://support.google.com/firebase/answer/7015592)

### Configure on iOS

Push notifications need to be active for the Xcode project for the app to be able to receive notifications. This can be done inside Xcode:

1. Open your app in Xcode (through `ios/<your_app_name>.xcodeproj`)
2. Having the root project file selected: 
    Capabilities > Push Notifications > Switch to 'ON'

## Usage

Use the init method to subscribe to a UPS and enable the app to start receiving Push Notifications from that server:

```javascript
  import RNUnifiedPush from 'react-native-unified-push';

  ...

  RNUnifiedPush.init(
  { 
    alias: '<id for this device>' ,
    url: '<url for your UPS server>',
    senderId: '<your sender id from UPS>',
    variantId: '<variant id for your app in UPS>',
    secret: '<variant secret for your app in UPS>'
  },
  () => {
    //success callback
  },
  (err) => {
    //error callback
  }
);
```
