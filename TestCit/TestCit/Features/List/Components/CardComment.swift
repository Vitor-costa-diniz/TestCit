//
//  CardComment.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import SwiftUI

struct CardComment: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(comment.email ?? "")
                    .font(.headline)
                
                Spacer()
            }
            
            Text(comment.body ?? "")
        }
        .frame(maxWidth: 358)
        .padding(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 2)
        }
    }
}

#Preview {
    CardComment(comment: .init())
}
