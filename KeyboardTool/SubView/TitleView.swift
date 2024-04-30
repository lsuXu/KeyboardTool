//
//  TitleView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct TitleView: View {
    
    let title : String
    
    let onFinish : () -> Void

    var body: some View {
        HStack{
            Spacer()
            Text(title)
                .font(.title2)
            Spacer()
        }
        .overlay(alignment: .trailing) {
            Button {
                onFinish()
            } label: {
                Text("完成")
                    .font(.title3)
            }
        }
    }
}
