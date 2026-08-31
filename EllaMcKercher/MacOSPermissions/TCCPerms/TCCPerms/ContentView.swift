import SwiftUI
import AVFoundation // For camera perms
import Photos

struct ContentView: View {
    @State private var cameraStatus: String = "Not requested"
    @State private var photosStatus: String = "Not requested"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("This application needs Camera access to demonstrate perms.")
            Button("Request Camera Access") {
                Task {
                    await requestCameraPermission()
                }
            }
            
            Divider()
            
            Text("This application needs Photo library access to demonstrate perms.")
            Button("Request Photos Access") {
                requestPhotosPermission()
            }
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
}

#Preview {
    ContentView()
}
