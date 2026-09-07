//
//  networkErrors.swift
//  
//
//  Created by Ella McKercher on 2026-09-07.
//

import Foundation

func fetchBadDecoding() async {
    guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
        print("Invalid URL")
        return
    }
    do {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(String.self, from: data)
        print("\(decoded)")
        
    } catch let error as DecodingError {
        switch error {
        case .keyNotFound:
            print("Decoding failed, missing key in JSON response")
        case .typeMismatch:
            print("Decoding failed, type mismatch")
        case .valueNotFound:
            print("Decoding failed, value not found")
        default:
            print("Decoding failed, unknown error")
        }
    } catch {
        print("Other error")
    }
}

func fetchTimeout() async {
    guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.timeoutInterval = 1 // Make the timeout too short
    
    do {
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print("Worked! Data: \(data)")
        
    } catch let error as URLError where error.code == .timedOut {
        print("Request timed out.")
    } catch {
        print("Other error occurred.")
    }
}

func runAll() async {
    await fetchBadDecoding()
    await fetchTimeout()
    exit(0)
}

Task {
    await runAll()
}

RunLoop.main.run()
