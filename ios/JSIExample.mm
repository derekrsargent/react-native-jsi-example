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

@implementation JSIExample

using namespace facebook;

@synthesize bridge = _bridge;
@synthesize methodQueue = _methodQueue;

RCT_EXPORT_MODULE()

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
  
  installJSIExample(*(facebook::jsi::Runtime *)cxxBridge.runtime);
}

- (void)invalidate {
  //cleanUpSequel();
  NSLog(@"invalidate (cleanup)");
}

- (NSString *)getModel {
  return @"iPhone 111 from Obj-C";
  
//  struct utsname systemInfo;
//
//  uname(&systemInfo);
//
//  return [NSString stringWithCString:systemInfo.machine
//                            encoding:NSUTF8StringEncoding];
}

@end
