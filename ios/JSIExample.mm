//
//  JSIExample.m
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

#import "react-native-jsi-example.h"
#import "JSIExample.h"
//#import "JSISampleObject.h"

#import <React/RCTBridge+Private.h>
#import <React/RCTUtils.h>
#import <iostream>
#import <Foundation/Foundation.h>

@implementation JSIExample

using namespace facebook;

@synthesize bridge = _bridge;
@synthesize methodQueue = _methodQueue;

RCT_EXPORT_MODULE()

// The threads are JS, Shadow, Main, Native

// Registering our method on the main queue (which has a subtle difference from the main thread). This queue is created automatically on behalf of the main thread and will always execute on the main thread
+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (void)setBridge:(RCTBridge *)bridge {
  _bridge = bridge;
  _setBridgeOnMainQueue = RCTIsMainQueue();

  RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
  if (!cxxBridge.runtime) {
    NSLog(@"+--------JSI binding unsuccessful--------+");
    return;
  }
  
  // Confirm we're on the main thread for curiosity sake
  NSLog(@"Is main thread? %i", (int)[NSThread isMainThread]);
  
  installJSIExample(*(facebook::jsi::Runtime *)cxxBridge.runtime);
}

@end
