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
            List(viewModel.posts) {
                Text($0.title ?? "")
            }
        .task {
            await viewModel.loadInitialPosts()
        }
    }
}

#Preview {
    ListView()
}
