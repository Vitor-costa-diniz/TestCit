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

extension Comment {}
