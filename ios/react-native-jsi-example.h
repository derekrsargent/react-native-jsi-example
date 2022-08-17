//
//  react-native-jsi-example.h
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

#import "JSISampleObject.h"

#import <jsi/jsilib.h>
#import <jsi/jsi.h>

void installJSIExample(facebook::jsi::Runtime& jsiRuntime);
void cleanUpJSIExample();
