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
    
    func loadPosts(reload: Bool = false) async {
        if posts.isEmpty || reload {
            await MainActor.run {
                isLoadingState = true
                do { isLoadingState = false }
            }
            
            await loadPostsService()
        }
    }
    
    func loadPostComments(reload: Bool = false) async {
        if comments.isEmpty || reload {
            await MainActor.run {
                isLoadingState = true
                do { isLoadingState = false }
            }
            
            await loadCommentsService()
        }
    }
}

// MARK: Private funcs
extension ListViewModel {
    private func loadPostsService() async {
        await MainActor.run {
            isLoadingState = true
            do { isLoadingState = false }
        }
        
        do {
            let newPosts = try await networkingService.loadPosts()
            await MainActor.run {
                posts = newPosts.shuffled()
            }
        } catch {
            errorType = .comment(message: "Failed to load posts. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
    
    private func loadCommentsService() async {
        do {
            let newComments = try await networkingService.loadComments(postId: self.selectedPost?.id ?? 1)
            await MainActor.run {
                self.comments.append(contentsOf: newComments)
            }
        } catch {
            errorType = .post(message: "Failed to load comments. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
}
