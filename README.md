# React Native JSI example with Obj-C

Using JSI to bind methods to the JS runtime.  
TODO: Replicate using TurboModules and Codegen.

## Build Requirements and Installation

Follow the typical React Native environment setup and build requirements as per https://reactnative.dev/docs/environment-setup

## Project Setups

See [Tutorial by Oscar Franco](https://ospfranco.com/post/2021/02/24/how-to-create-a-javascript-jsi-module/) for additional information.    

- Create an empty react native project using `npx react-native init ProjectName`. I wanted to use a bare project instead of using `react-native-turbo-starter` or similiar. 
- Add `react-native-jsi-example.cpp`, `react-native-jsi-example.h`, `JSIExample.cpp`, `JSIExample.h` files in the ios folder using XCode. 
- Update `App.js` to invoke the global method and do a console log for this example.
