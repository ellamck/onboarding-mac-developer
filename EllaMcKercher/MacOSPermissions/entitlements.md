# Entitlements

Entitlements are a file that declares which permissions and capabilities an app is allowed to request. TCC handles the runtime consent from the user, while entitlement handles the application's requests to permissions.

My `TCCPerms.entitlements` file does the following:

- `com.apple.security.app-sandbox`: allows the App Sandbox for this app
- `com.apple.security.device.camera`: allows for requesting camera access
- `com.apple.security.device.audio-input`: allows for microphone/audio input request

Without the entitlements file, calling .requestAccess in my ContentView.swift file would be blocked by the sandbox since they are the first authorizations to occur.
