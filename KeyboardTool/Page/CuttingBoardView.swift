//
//  CuttingBoardView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct CuttingBoardView: View {
    
    let data : [Int] = [1,2,3,4,5,6,7]
    
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView {
                    LazyVStack(spacing : 16){
                        ForEach(data , id: \.self) { item in
                            VStack{
                                HStack{
                                    Text("2024-04-28 15:15:55")
                                        .font(.system(size: 11))
                                    Spacer()
                                    Image(systemName: "doc.on.doc")
                                        .imageScale(.small)
                                }
                                HStack{
                                    Text("的嘎到底吃蛋糕吃蔬菜水果vv收费道具发vv给客服v的不数据发布v")
                                    Spacer()
                                }
                            }
                            .roundBackground(radius: 10)
                        }
                    }
                    .padding(.horizontal , 20)
                }
            }
            .background(.mainBg)
            .navigationTitle(Text("剪切板"))
        }
    }
}

#Preview {
    CuttingBoardView()
}
