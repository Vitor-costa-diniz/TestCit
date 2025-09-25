//
//  DetailView.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ListViewModel
    let post: Post?
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(post?.title ?? "")
                    .font(.title)
                    .padding(.bottom,4)
                
                Text(post?.body ?? "")
                    .font(.title3)
            }
            .multilineTextAlignment(.center)
            .padding(.top)
            .padding(.bottom, 48)
            
            Text("Comments")
                .font(.largeTitle)
                .padding(.bottom, 4)
            
            if viewModel.errorType?.type == .comment {
                Group {
                    Text("Error Loading comments")
                    Text(viewModel.errorType?.message ?? "")
                }
                .font(.largeTitle)
            } else {
                commentSection
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .task { await viewModel.loadPostComments() }
    }
    
    private var commentSection: some View {
        VStack(alignment: .center) {
            if viewModel.isLoadingState {
                ProgressView(label: {
                    Text("Loading")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                })
                .progressViewStyle(.circular)
            } else {
                VStack(alignment: .leading) {
                    ForEach(viewModel.comments) {
                        Text($0.name ?? "")
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(post: .init())
        .environmentObject(ListViewModel())
}
