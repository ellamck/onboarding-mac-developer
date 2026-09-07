//
//  MockAPITests.swift
//  MockAPITests
//
//  Created by Ella McKercher on 2026-09-07.
//

import Testing
import Foundation
@testable import MockAPI

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct MockAPITests {

    @Test("Test if fetching a post actually returns valid data from JSONPlaceholder")
      func testFetchPost() async throws {
          guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
              Issue.record("Invalid URL")
              return
          }
          
          let post = try await NetworkManager.shared.fetch(url: url, as: Post.self)
          
          #expect(post.id == 1)
          #expect(!post.title.isEmpty)
    }

}
