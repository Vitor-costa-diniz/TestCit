//
//  JSONPlaceholderService.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

final class JSONPlaceholderService: NetworkingService {
    private let baseURL = ProcessInfo.processInfo.environment["API_BASE_URL"] ?? ""
    
    func loadPosts() async throws -> [Post] {
        let urlString = "\(baseURL)/posts"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func loadComments(postId: Int) async throws -> [Comment] {
        let urlString = "\(baseURL)/posts/\(postId)/comments"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Comment].self, from: data)
    }
}
