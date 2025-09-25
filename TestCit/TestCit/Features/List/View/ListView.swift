//
//  ListView.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel: ListViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.errorType?.type == .post {
                    Group {
                        Text("Error Loading posts")
                        Text(viewModel.errorType?.message ?? "")
                    }
                    .font(.largeTitle)
                } else {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.posts) { item in
                            CardList(item: item)
                                .onTapGesture { viewModel.selectedPost = item }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoadingState {
                    ProgressView(label: {
                        Text("Loading")
                            .font(.caption)
                            .foregroundStyle(Color.secondary)
                    })
                    .progressViewStyle(.circular)
                }
            }
            .padding(.horizontal, 2)
            .scrollIndicators(.hidden)
            .navigationTitle("Posts")
            .navigationDestination(item: $viewModel.selectedPost) { post in
                DetailView(post: post)
                    .environmentObject(viewModel)
                    .onDisappear { viewModel.comments.removeAll() }
            }
            .refreshable {
                await viewModel.loadPosts(reload: true)
            }
            .task {
                await viewModel.loadPosts()
            }
        }
    }
}

#Preview {
    ListView()
}
