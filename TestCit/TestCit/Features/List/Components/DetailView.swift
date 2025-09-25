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
            
            VStack(alignment: .center) {
                if viewModel.comments.isEmpty {
                    Group {
                        Text("This post dont have any comments yet!")
                            .padding(.bottom, 4)
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundStyle(.gray)
                } else {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.comments) {
                            Text($0.name ?? "")
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .task { await viewModel.loadPostComments() }
    }
}

#Preview {
    DetailView(post: .init())
        .environmentObject(ListViewModel())
}
