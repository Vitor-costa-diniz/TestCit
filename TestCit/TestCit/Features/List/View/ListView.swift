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
                ForEach(viewModel.posts) {
                    CardList(item: $0)
                }
                .padding(.horizontal, 2)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Posts")
            .task {
                await viewModel.loadInitialPosts()
            }
        }
    }
}

#Preview {
    ListView()
}
