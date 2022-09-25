//
//  JSIExample.h
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

#import <React/RCTBridgeModule.h>

@interface JSIExample : NSObject <RCTBridgeModule>

// This tells Obj-C you will be registering the function on the main thread, which is required for JSI to work
@property(nonatomic, assign) BOOL setBridgeOnMainQueue;

@end
