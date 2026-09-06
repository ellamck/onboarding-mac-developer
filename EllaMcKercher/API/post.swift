//
//  post.swift
//  
//
//  Created by Ella McKercher on 2026-09-04.
//

import Foundation

struct Post: Codable {
    let title: String
    let body: String
    let userId: Int
}

struct Response: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

func sendPostRequest() async {
    guard let url = URL(string: "https://httpbin.org/post") else {
        print("Bad URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let post = Post(title: "Hello", body: "Hello", userId: 1)
    
    do {
        let json = try JSONEncoder().encode(post)
        request.httpBody = json
        
        let (data, _) = try await URLSession.shared.data(for: request)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
    } catch {
        print("Error: \(error)")
    }
    exit(0)
}

Task {
    await sendPostRequest()
}

RunLoop.main.run() // Without this task will not execute
