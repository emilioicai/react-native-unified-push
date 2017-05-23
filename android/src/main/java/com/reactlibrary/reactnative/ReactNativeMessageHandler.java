/**
 *    Copyright 2017 Copyright Red Hat, Inc, and individual contributors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package com.reactlibrary.reactnative;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import org.jboss.aerogear.android.unifiedpush.MessageHandler;

public class ReactNativeMessageHandler implements MessageHandler {
  @Override
  public void onMessage(final Context androidContext, final Bundle message) {
    Handler handler = new Handler(Looper.getMainLooper());
    handler.post(
        new Runnable() {
          public void run() {
            final ReactInstanceManager reactInstanceManager =
                ((ReactApplication) androidContext.getApplicationContext())
                    .getReactNativeHost()
                    .getReactInstanceManager();
            ReactContext reactContext = reactInstanceManager.getCurrentReactContext();
            if (reactContext == null) {
              reactInstanceManager.addReactInstanceEventListener(
                  new ReactInstanceManager.ReactInstanceEventListener() {
                    @Override
                    public void onReactContextInitialized(ReactContext reactContext) {
                      sendToJavaScript(reactContext, message.getString("alert"));
                      reactInstanceManager.removeReactInstanceEventListener(this);
                    }
                  });
              if (!reactInstanceManager.hasStartedCreatingInitialContext()) {
                reactInstanceManager.createReactContextInBackground();
              }
            } else {
              sendToJavaScript(reactContext, message.getString("alert"));
            }
          }
        });
  }

  private void sendToJavaScript(ReactContext reactContext, String alert) {
    WritableMap params = Arguments.createMap();
    params.putString("alert", alert);
    reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
        .emit("onDefaultMessage", params);
  }
}
