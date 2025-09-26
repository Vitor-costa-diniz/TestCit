//
//  MockNetworkingService.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

final class MockNetworkingService: NetworkingService {
    var shouldThrowError = false
    
    func loadPosts() async throws -> [Post] {
        if shouldThrowError {
            throw URLError(.badURL)
        }
        return Post.mockPosts
    }
    
    func loadComments(postId: Int) async throws -> [Comment] {
        if shouldThrowError {
            throw URLError(.badURL)
        }
        return Comment.mockComments
    }
}
