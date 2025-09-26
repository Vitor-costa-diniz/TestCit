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
    private var networkTask: Task<Void, Never>?
    
    init(networkingService: NetworkingService = JSONPlaceholderService()) {
        self.networkingService = networkingService
    }
    
    func loadPosts(reload: Bool = false) async {
        if networkTask == nil || networkTask?.isCancelled == true {
            networkTask = Task {
                await loadPostsService()
            }
            
            await networkTask?.value
            networkTask = nil
        }
    }
    
    func loadPostComments(reload: Bool = false) async {
        if networkTask == nil || networkTask?.isCancelled == true {
            networkTask = Task {
                await loadCommentsService()
            }
            
            await networkTask?.value
            networkTask = nil
        }
    }
}

// MARK: Private funcs
extension ListViewModel {
    @MainActor
    private func loadPostsService() async {
        isLoadingState = true
        defer { isLoadingState = false }
        do {
            let newPosts = try await networkingService.loadPosts()
            posts = newPosts.shuffled()
            errorType = nil
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                errorType = .post(message: "Too many request made at same time.")
            }
            
            errorType = .post(message: "Failed to load posts. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
    
    @MainActor
    private func loadCommentsService() async {
        isLoadingState = true
        defer { isLoadingState = false }
        do {
            let newComments = try await networkingService.loadComments(postId: self.selectedPost?.id ?? 1)
            self.comments.append(contentsOf: newComments)
            errorType = nil
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                errorType = .comment(message: "Too many request made at same time.")
            }
            
            errorType = .comment(message: "Failed to load comments. This might be due to a poor internet connection or a server issue. Please try again later.")
        }
    }
}
