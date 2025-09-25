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
                ForEach(viewModel.posts) { item in
                    CardList(item: item)
                        .padding(.bottom, 8)
                        .onTapGesture { viewModel.selectedPost = item }
                }
                .padding(.horizontal, 2)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Posts")
            .navigationDestination(item: $viewModel.selectedPost) { post in
                DetailView(post: post)
                    .environmentObject(viewModel)
            }
            .task {
                await viewModel.loadInitialPosts()
            }
        }
    }
}

#Preview {
    ListView()
}
