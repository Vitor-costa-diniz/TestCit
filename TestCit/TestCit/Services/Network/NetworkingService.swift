//
//  NetworkingService.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

protocol NetworkingService {
    func loadPosts(start: Int, limit: Int) async throws -> [Post]
}
