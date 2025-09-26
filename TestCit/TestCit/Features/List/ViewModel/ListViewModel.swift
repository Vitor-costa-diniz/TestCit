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
    @Published var isLoadingState = false
    
    init(networkingService: NetworkingService = JSONPlaceholderService()) {
        self.networkingService = networkingService
    }
    
    @MainActor
    func loadPosts(reload: Bool = false) async {
        if posts.isEmpty || reload {
            isLoadingState = true
            await loadPostsService()
            isLoadingState = false
        }
    }
    
    @MainActor
    func loadPostComments(reload: Bool = false) async {
        if comments.isEmpty || reload {
            isLoadingState = true
            await loadCommentsService()
            isLoadingState = false
        }
    }
}

// MARK: Private funcs
extension ListViewModel {
    @MainActor
    private func loadPostsService() async {
        do {
            let newPosts = try await networkingService.loadPosts()
            posts = newPosts.shuffled()
        } catch {
            errorType = .post(message: "Failed to load posts. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
    
    @MainActor
    private func loadCommentsService() async {
        do {
            let newComments = try await networkingService.loadComments(postId: self.selectedPost?.id ?? 1)
            self.comments.append(contentsOf: newComments)
        } catch {
            errorType = .comment(message: "Failed to load comments. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
}
