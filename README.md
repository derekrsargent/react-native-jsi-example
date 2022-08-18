# React Native JSI example with Obj-C

Using JSI to bind methods to the JS runtime from a bare react native project.  

## Build Requirements and Installation

Follow the typical React Native environment setup and build requirements as per https://reactnative.dev/docs/environment-setup

## Project Setups

See [Tutorial by Oscar Franco](https://ospfranco.com/post/2021/02/24/how-to-create-a-javascript-jsi-module/) for additional information.    

The steps followed to create this project:
- Create an empty react native project using `npx react-native init ProjectName`. I wanted to use a bare project instead of using `react-native-turbo-starter`, `react-native-builder-bob` or similiar. 
- Add `react-native-jsi-example.h`, `react-native-jsi-example.cpp`, `JSIExample.h`, `JSIExample.mm` files in the ios folder using Xcode. 
- Add `JSISampleObject.h`, `JSISampleObject.m` files in the ios folder using Xcode. This is the Objective-C method file (.m instead of .mm since it is pure Objective-C).
- Update `App.js` to invoke the global method and do a console log for this example.
- If JSI binding is unsuccessful try cleaning the build folder using Xcode.

## Run Project

Run `yarn ios` in the project root directory. 
