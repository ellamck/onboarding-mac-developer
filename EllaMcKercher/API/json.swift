//
//  json.swift
//  
//
//  Created by Ella McKercher on 2026-09-02.
//

import Foundation // Includes URL, URLSession

//
func fetchJSON() async {
    // URL changes text into an actual URL object but it can fail so must have a guard
    guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=-33.87&longitude=151.21&current_weather=true") else {
        print("Bad URL")
        return
    }
    
    do {
        // URLSession.shared is a prebuilt Apple URLSession instance for simple things
        // .data performs GET to the URL and sends back data and the metadata response (data, URLResponse) but we only need the data
        let (data, _) = try await URLSession.shared.data(from: url) // need to use try as this could throw
        
        // Interpret bytes as readable text
        // if let because if this fails don't need whole function to fail
        if let jsonData = String(data: data, encoding: .utf8) {
            print(jsonData)
        }
    } catch {
        print("Error fetching JSON: \(error)")
    }
}

// Must wrap call in a Task because this creates asynch context where await is allowed
Task {
    await fetchJSON()
    exit(0)
}

// Ensure that Task completes so just run a loop, the exit will stop this after Task is finished
RunLoop.main.run()
