# Functional Tests

This is the cucumber style BDD framework for testing mobile apps using JavaScript Appium driver.

###Framework Capabilities
- [x] Cross platform test run with Appium on Android and iOS
- [x] Cucumber integration for BDD layer
- [x] Extract into Page Object pattern
- [x] Write base page operations for android and iOS
- [x] Pull config files based on environments
- [x] Add config to run on multiple android versions
- [x] Hooks & World definitions
- [x] Introducing Q for promises
- [x] Resolving chai and chai-as-promised frameworks for BDD style assertions
- [x] Generate cucumber reports using grunt-cucumberjs
- [x] Screenshots on failure
- [x] Runtime stub creation using Mountebank for backend services (names 'Qloud' here)
- [x] Introduce grunt tasks to run ios and android tests separately and
- [x] Grunt tasks to start and stop appium from command line for CI integration
- [x] Run tests on real devices

###Setup Automation Framework
- Install node v0.10.33
- Install java 1.7.0_71
- Appium 1.3.7 GUI server https://github.com/appium/appium-dot-app
- npm install

###Setup Mountebank stub
- Follow simple steps to start Mountebank http://www.mbtest.org/docs/gettingStarted
- Mountebank runs on 2525 port by default

###Steps to Run Android Suite
- Start specific version of android emulator before test run or connect real device.
- To run android tests using grunt - grunt android:4.4 (specify version number as required)
- To run android tests using cucumber, PLATFORM='android' VERSION='4.2' cucumber.js --tags @android
- Reports will be generated inside reports folder as android-report.html
- Error logs will be generated logs folder

###Steps to Run Ios Suite
- To run ios tests - grunt ios:8.3
- Reports will be generated inside reports folder for ios-report.html
