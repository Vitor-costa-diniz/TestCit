//
//  ListViewModel.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import Foundation

final class ListViewModel: ObservableObject {
    private let networkingService: NetworkingService
    
    @Published var posts: [Post] = []
    @Published var comments: [Comment] = []
    @Published var selectedPost: Post?
    private var isLoading = false
    
    init(networkingService: NetworkingService = JSONPlaceholderService()) {
        self.networkingService = networkingService
    }
    
    func loadInitialPosts() async {
        if posts.isEmpty {
            await loadPosts()
        }
    }
    
    func loadPostComments() async {
        if comments.isEmpty {
            do {
                let newComments = try await networkingService.loadComments(postId: self.selectedPost?.id ?? 1)
                await MainActor.run {
                    self.comments.append(contentsOf: newComments)
                }
            } catch {
                print("Error loading comments: \(error)")
            }
        }
    }
}

// MARK: Private funcs
extension ListViewModel {
    private func loadPosts() async {
        do {
            let newPosts = try await networkingService.loadPosts()
            await MainActor.run {
                posts = newPosts.shuffled()
            }
        } catch {
            print("Error loading posts: \(error)")
        }
    }
}
