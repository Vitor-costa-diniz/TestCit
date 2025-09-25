//
//  Comment.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: Int?
    let postId: Int?
    let name: String?
    let email: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case id, postId, name, email, body
    }
    
    init(id: Int?, postId: Int?, name: String?, email: String?, body: String?) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}

extension Comment {
    static let mockPosts: [Comment] = [
        .init(id: 1, postId: 1, name: "First name", email: "first@gmail.com", body: "first body"),
        .init(id: 2, postId: 2, name: "Second name", email: "Second@gmail.com", body: "Second body"),
        .init(id: 3, postId: 3, name: "Third name", email: "Third@gmail.com", body: "Third body"),
    ]
    
    init() {
        self.id = 1
        self.postId = 1
        self.name = "first post title"
        self.email = "firts@gmail.com"
        self.body = "Test test test test"
    }
}
