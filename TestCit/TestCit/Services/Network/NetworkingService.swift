//
//  NetworkingService.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

protocol NetworkingService {
    func loadPosts() async throws -> [Post]
    func loadComments(postId: Int) async throws -> [Comment]
}
