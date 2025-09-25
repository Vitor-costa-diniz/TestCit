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
    @Published var errorType: ErrorType?
    private var isLoading = false
    
    init(networkingService: NetworkingService = JSONPlaceholderService()) {
        self.networkingService = networkingService
    }
    
    func loadPosts(reload: Bool = false) async {
        if posts.isEmpty || reload {
            await loadPostsService()
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
                errorType = .post(message: "Error loading comments: \(error)")
            }
        }
    }
    
    func retry() async {
        await loadPosts(reload: true)
    }
}

// MARK: Private funcs
extension ListViewModel {
    private func loadPostsService() async {
        do {
            let newPosts = try await networkingService.loadPosts()
            await MainActor.run {
                posts = newPosts.shuffled()
            }
        } catch {
            errorType = .comment(message: "Error loading comments: \(error)")
        }
    }
}
