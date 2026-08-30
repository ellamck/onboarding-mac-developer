# Code Signing Basics

Apple needs to guarantee any code running on an Apple device can be traced back to a known, verified developer. The code also needs to be tamper-proof, so that all the applications running on real devices can be safely distributed.

## Code Signing

Code signing is a cryptographic signature attached to the application, this proves it came from a developer with a real identity and that the code has not been altered since the app was signed. When the application is built and released for distribution, Xcode signs the compiled app with your Apple Developer account's generated certificate.

The key step is that when someone runs the application that you developed, the OS on their device checks that signature against Apple's records, and will only allow the application to run if it is consistent with the records (untampered and valid).

There is a Development certificate, which is used for when you are developing, building and testing the application on your own device. Then there is the Distribution certificate, which is for official release to the App Store.

## Provisioning Profile

Provisioning profiles are essentially a package that includes the app you developed, your developer account's certificate, and the devices allowed to run the code. Xcode and the OS on the device will check this before authorizing the application to run.

The provisioning profile contains the following:

- Application ID (unique identifier)
- Developer certificate
- List of authorized devices (you need to register specific device's IDs before testing on it)
- Entitlements (the list of permissions your application is allowed to use and access)
