//
//  ContentView.swift
//  MockAPI
//
//  Created by Ella McKercher on 2026-09-07.
//

import SwiftUI

// define the shape of a post so the list can tell apart titles and bodies
struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct ContentView: View {
    @State private var posts: [Post] = [] // hold a list of all the posts. state so that it redraws each time something in the array changes
    @State private var errorMessage: String?
    
    var body: some View {
        List(posts) {
            // run this closure once for every post in the array
            post in VStack(alignment: .leading) {
                Text(post.title).font(.headline)
                Text(post.body).font(.subheadline)
            }
        }
        // make it so loadPosts automatically runs as soon as the view appears
        // since it is async use task
        .task {
            await loadPosts()
        }
    }
    
    func loadPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            errorMessage = "Bad URL"
            return
        }
        
        // use network manager class
        do {
            posts = try await NetworkManager.shared.fetch(url: url, as: [Post].self)
        } catch {
            errorMessage = "Error: \(error)"
        }
    }
}

#Preview {
    ContentView()
}
