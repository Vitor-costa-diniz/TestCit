//
//  ListViewModel.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

final class ListViewModel: ObservableObject {
    private let service: NetworkingService
    
    @Published var posts: [Post] = []
    private var isLoading = false
    private var currentPage = 0
    private let limit = 30
    
    init(service: NetworkingService = JSONPlaceholderService()) {
        self.service = service
    }
    
    func loadInitialPosts() async {
        if posts.isEmpty {
            await loadPosts()
        }
    }
}

// MARK: Private funcs
extension ListViewModel {
    private func loadPosts() async {
        do {
            let newPosts = try await service.loadPosts(start: currentPage * limit, limit: limit)
            await MainActor.run {
                posts.append(contentsOf: newPosts)
            }
            currentPage += 1
        } catch {
            print("Error loading posts: \(error)")
        }
    }
}
