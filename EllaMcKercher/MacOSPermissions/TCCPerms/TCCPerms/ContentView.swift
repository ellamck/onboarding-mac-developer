import SwiftUI
import AVFoundation // For camera perms
import Photos
import ApplicationServices // For accessibility API

struct ContentView: View {
    @State private var cameraStatus: String = "Not requested"
    @State private var photosStatus: String = "Not requested"
    @State private var accessibilityStatus: String = "Not checked"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This application needs Camera access to demonstrate perms.")
            Button("Request Camera Access") {
                Task {
                    await requestCameraPermission()
                }
            }
            Text("Camera status: \(cameraStatus)")
            
            Divider()
            
            Text("This application needs Photo library access to demonstrate perms.")
            Button("Request Photos Access") {
                requestPhotosPermission()
            }
            Text("Photos status: \(photosStatus)")
            
            Divider()
            
            Text("Is there Accessibility permissions for this Application?")
            Button("Check Accessibility Access") {
                checkAccessibilityPermission()
            }
            Text("Accessibility status: \(accessibilityStatus)")
        }
        .padding()
    }
    
    // Following https://developer.apple.com/documentation/avfoundation/requesting-authorization-to-capture-and-save-media
    var isCameraAuthorized: Bool {
        // get async indicates the the bool requires async, so accessing the bool runs an async task each time, and you have to wait for the result
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            // Determine if the user previously authorized camera access
            var authorized = status == .authorized
            
            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                authorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return authorized
        }
    }
    
    func requestCameraPermission() async {
        // Use the bool from above
        let authorized = await isCameraAuthorized
        cameraStatus = authorized ? "Granted" : "Denied"
    }
    
    // photo library does not have an async equivalent
    func requestPhotosPermission() {
        PHPhotoLibrary.requestAuthorization { status in // request perms
            // any code for the UI must run on main thread
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    photosStatus = "Granted"
                case .denied, .restricted:
                    photosStatus = "Denied"
                case .notDetermined:
                    photosStatus = "Not determined"
                case .limited:
                    photosStatus = "Limited access"
                @unknown default:
                    photosStatus = "Unknown"
                }
            }
        }
    }
    
    func checkAccessibilityPermission() {
        //https://developer.apple.com/documentation/applicationservices/1460720-axisprocesstrusted
        let trusted = AXIsProcessTrusted()
        accessibilityStatus = trusted ? "Trusted" : "Not trusted"
        if !trusted {
            requestAccessibilityPermission()
        }
    }
    
    func requestAccessibilityPermission() {
        // options = a dictionary where key = special text label Apple uses to mean prompt the user
        // value is true
        // therefore show prompt, unwrap it for swift, and convert it to string
        // essentially options = ["prompt": true]
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        // if not trusted, then it will prompt as a side effect because AXIsProcessTrustedWithOptions can trigger the prompt if WithOptions
        let trusted = AXIsProcessTrustedWithOptions(options)
        accessibilityStatus = trusted ? "Trusted" : "Not Trusted (check System Settings)"
    }
}

#Preview {
    ContentView()
}
