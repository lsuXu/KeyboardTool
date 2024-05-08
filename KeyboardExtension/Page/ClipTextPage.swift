//
//  ClipTextPage.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/8.
//

import SwiftUI

struct ClipTextPage: View {
    
    @StateObject var model  = ClipBoardViewModel.shared
    
    let onTextClick : (_ text : String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(model.clipInfos ,  id: \.id){ item in
                    HStack{
                        Text(item.text)
                            .font(.normalText)
                        Spacer()
                    }
                    .roundBackground(radius: 8 , color: Color.mainColor, horizontal: 6,vertical: 8)
                    .onTapGesture {
                        onTextClick(item.text)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)

    }
}
