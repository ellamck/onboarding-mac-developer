import Foundation

func downloadFile() async -> String {
    print("Download started")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "File successfully downloaded"
}

func playFile() async -> String {
    // try? converts the result into an optional
    // If the function is successful, the actual value will be wrapped in an optional
    // if an error is thrown, the result just becomes nil
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return("File is playing")
}

Task {
    print("Starting...")
    
    let downloadedFile = await downloadFile()
    let playingFile = await playFile()
    
    print("\(downloadedFile) and \(playingFile)")
}
