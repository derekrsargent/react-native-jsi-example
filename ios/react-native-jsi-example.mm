//
//  react-native-jsi-example.cpp
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

// Import our header file to implement the `installJSIExample` and `cleanUpJSIExample` functions
#import "react-native-jsi-example.h"
//#import "JSISampleObject.h"

#import <iostream>

// The namespace allows for syntactic sugar around the JSI objects. ex. call: jsi::Function instead of facebook::jsi::Function
using namespace facebook;

// We get the runtime from the obj-c code and we create our native functions here
void installJSIExample(jsi::Runtime& jsiRuntime) {
  
  std::cout << "jsiExample: " << std::endl;
  //std::cout << [jsiSampleObject okloll] << std::endl;
  std::cout << "^jsiExample: " << std::endl;
  
  // jsi::Function::createFromHostFunction will create a JavaScript function based on a "host" (read C++) function
  auto multiplyd = jsi::Function::createFromHostFunction(
    jsiRuntime, // JSI runtime instance
    jsi::PropNameID::forAscii(jsiRuntime, "multiplyd"), // Internal function name
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
  jsiRuntime.global().setProperty(jsiRuntime, "multiplyd", std::move(multiplyd));
  
  auto getDeviceName = jsi::Function::createFromHostFunction(
                                                             jsiRuntime,
                                                             jsi::PropNameID::forAscii(jsiRuntime, "getDeviceName"),
                                                             0,
  [](jsi::Runtime &runtime, const jsi::Value &thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
    std::string helloworld = "Hello getDeviceName from C++";
    return jsi::Value(runtime, jsi::String::createFromUtf8(runtime, helloworld));
  });
  
  // Registers the function on the global object
  jsiRuntime.global().setProperty(jsiRuntime, "getDeviceName", std::move(getDeviceName));
  
}

void cleanUpJSIExample() {
  // intentionally left blank
}
