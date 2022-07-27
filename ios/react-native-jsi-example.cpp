//
//  react-native-jsi-example.cpp
//  ReactNativeJsi2
//
//  Created by Derek Sargent on 2022-07-27.
//

// Import our header file to implement the `installJSIExample` and `cleanUpJSIExample` functions
#include "react-native-jsi-example.h"
// sstream contains functions to manipulate strings in C++
#include <sstream>

// The namespace allows for syntactic sugar around the JSI objects. ex. call: jsi::Function instead of facebook::jsi::Function
using namespace facebook;

// We get the runtime from the obj-c code and we create our native functions here
void installJSIExample(jsi::Runtime& jsiRuntime) {
  // jsi::Function::createFromHostFunction will create a JavaScript function based on a "host" (read C++) function
  auto multiplyd = jsi::Function::createFromHostFunction(
    jsiRuntime, // JSI runtime instance
    jsi::PropNameID::forAscii(jsiRuntime, "multiplyd"), // Internal function name
    1, // Number of arguments in function
    // This is a C++ lambda function, the empty [] at the beginning is used to capture pointer/references so that they don't get de-allocated
    // Then you get another instance of the runtime to use inside the function, a "this" value from the javascript world, a pointer to the arguments (you can treat it as an array) and finally a count for the number of arguments
    // Finally the function needs to return a jsi::Value (read JavaScript value)
    [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {

      // the jsi::Value has a lot of helper methods for you to manipulate the data
      if(!arguments[0].isNumber() || !arguments[1].isNumber()) {
        jsi::detail::throwJSError(runtime, "Non number arguments passed to sequel");
      }

      double res = 42;
      return jsi::Value(res);
    }
  );

  // Registers the function on the global object
  jsiRuntime.global().setProperty(jsiRuntime, "multiplyd", std::move(multiplyd));
}

void cleanUpJSIExample() {
  // intentionally left blank
}
