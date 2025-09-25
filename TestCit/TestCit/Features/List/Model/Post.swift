//
//  Post.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

struct Post: Codable, Identifiable, Hashable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title, body
    }
    
    init(userId: Int?, id: Int?, title: String?, body: String?) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

extension Post {
    static let mockPosts: [Post] = [
        .init(userId: 1, id: 1, title: "first post title", body: "first post body"),
        .init(userId: 2, id: 2, title: "second post title", body: "second post body"),
        .init(userId: 3, id: 3, title: "first post title", body: "first post body")
    ]
    
    init() {
        self.userId = 1
        self.id = 1
        self.title = "first post title"
        self.body = "first post body"
    }
}
