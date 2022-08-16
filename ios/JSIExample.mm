//
//  JSIExample.m
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

#import "JSIExample.h"
#import "react-native-jsi-example.h"
#import "JSISampleObject.h"

#import <React/RCTBridge+Private.h>
#import <React/RCTUtils.h>

@implementation JSIExample

using namespace facebook;

@synthesize bridge= _bridge;
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
    NSLog(@"-+-+-+---------JSI binding unsuccessful");
    return;
  }
  
  id jsiSampleObject = [[JSISampleObject alloc] init];
  //NSLog(typeid(self));
  installJSIExample(*(facebook::jsi::Runtime *)cxxBridge.runtime, self, jsiSampleObject);
}

- (void)invalidate {
  //cleanUpSequel();
  NSLog(@"invalidate (cleanup)");
}

//- (int)returnFunnyNumber {
//  return 69;
//}

- (NSString *)getModel {
  return @"iPhone 111 from Obj-C";
  
//  struct utsname systemInfo;
//
//  uname(&systemInfo);
//
//  return [NSString stringWithCString:systemInfo.machine
//                            encoding:NSUTF8StringEncoding];
}

// We get the runtime from the obj-c code and we create our native functions here
static void installJSIExample1(jsi::Runtime& jsiRuntime, JSIExample* jsiExample) {
  // jsi::Function::createFromHostFunction will create a JavaScript function based on a "host" (read C++) function
  auto multiplyd1 = jsi::Function::createFromHostFunction(
    jsiRuntime, // JSI runtime instance
    jsi::PropNameID::forAscii(jsiRuntime, "multiplyd1"), // Internal function name
    2, // Number of arguments in function
    // This is a C++ lambda function, the empty [] at the beginning is used to capture pointer/references so that they don't get de-allocated
    // Then you get another instance of the runtime to use inside the function, a "this" value from the javascript world, a pointer to the arguments (you can treat it as an array) and finally a count for the number of arguments
    // Finally the function needs to return a jsi::Value (read JavaScript value)
    [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {

      // the jsi::Value has a lot of helper methods for you to manipulate the data
      if(!arguments[0].isNumber() || !arguments[1].isNumber()) {
        jsi::detail::throwJSError(runtime, "Non number arguments passed to sequel");
      }

      double res = arguments[0].getNumber() * arguments[1].getNumber();
      return jsi::Value(res);
    }
  );
  
  // Registers the function on the global object
  jsiRuntime.global().setProperty(jsiRuntime, "multiplyd1", std::move(multiplyd1));
}

@end
