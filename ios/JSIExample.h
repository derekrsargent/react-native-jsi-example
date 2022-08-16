//
//  JSIExample.h
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

#import <React/RCTBridgeModule.h>

@interface JSIExample : NSObject <RCTBridgeModule>

@property(nonatomic, assign) BOOL setBridgeOnMainQueue;

//- (int) returnFunnyNumber;
//- (void)invalidate;
//- (NSString * )getModel;

@end
