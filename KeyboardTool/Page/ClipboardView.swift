//
//  CuttingBoardView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct ClipboardView: View {
    
    @StateObject var model = ClipBoardViewModel.shared
    
    let data : [Int] = [1,2,3,4,5,6,7]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.clipInfos , id: \.id) { item in
                    VStack{
                        HStack{
                            Text(item.createTime.formatTime())
                                .font(.system(size: 11))
                            
                            Spacer()
                            Image(systemName: "doc.on.doc")
                                .imageScale(.small)
                        }
                        HStack{
                            Text(item.text)
                                .font(.clipTextFont)
                            Spacer()
                        }
                    }
                    .swipeActions(edge : .trailing , allowsFullSwipe: true) {
                        Button() {
                            model.deleteClipboardInfo(item)
                        } label: {
                            Text("删除")
                        }
                        .tint(Color.red)
                    }
                }
            }
            .listStyle(.sidebar)
            .background(.mainBg)
            .navigationTitle(Text("剪切板"))
        }
    }
}

#Preview {
    ClipboardView()
}
