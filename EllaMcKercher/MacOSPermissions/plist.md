# Info.plist Permission Keys

Entitlements are for determining on a sandbox-level if an application can request a capability, whereas Info.plist usage keys is the message that shows to the user when the request for the permission is made. TCC is then for handling the user's consent and the actions based on that. Without the necessary Info.plist usage keys, the application with crash immediately.

The key values are the strings that explain to the user why a request is being made and why an application requires that specific permission. They control how and if the permission prompt can be shown.

## Keys Used in my Sample Project

I used the following keys in TCCPerms:

- `NSCameraUsageDescription`: "This app needs camera access to demonstrate TCC permissions."
- `NSPhotoLibraryUsageDescription`: "This app needs photo library access to demonstrate TCC permissions."
