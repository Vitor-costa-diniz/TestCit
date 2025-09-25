//
//  Post.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    static let mockPosts: [Post] = [
        .init(userId: 1, id: 1, title: "first post title", body: "first post body"),
        .init(userId: 2, id: 2, title: "second post title", body: "second post body"),
        .init(userId: 3, id: 3, title: "first post title", body: "first post body")
    ]
}
