//
//  CardList.swift
//  TestCit
//
//  Created by Vitor Costa on 25/09/25.
//

import SwiftUI

struct CardList: View {
    let item: Post
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(item.id ?? 0)")
                .font(.title)
                .padding(.leading, 4)
            
            Spacer()
            
            Text(item.title ?? "test title lorem ")
                .font(.title2)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(.trailing, 4)
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
    CardList(item: .init(userId: 1, id: 1, title: "test tbjasdadasdasddsb", body: "lorem ipsulum body"))
}
