//
//  CuttingBoardView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI
import AlertToast


struct ClipboardView: View {
    
    @AppStorage(Config.keySettingTouchClip) var keySettingTouchClip : Bool = true

    @StateObject var model = ClipBoardViewModel.shared
        
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
                    .onTapGesture {
                        if keySettingTouchClip {
                            UIPasteboard.general.string = item.text
                            model.showToast("已复制到剪切板")
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
                .onMove(perform: model.clipInfoMove)
            }
            .listStyle(.sidebar)
            .background(.mainBg)
            .navigationTitle(Text("剪切板"))
            .toast(isPresenting: $model.showToast,duration: 2, tapToDismiss: true,offsetY: 0, alert: {
                AlertToast(displayMode: .alert, type: .regular,title: model.toastMsg)
            })
        }
    }
}

#Preview {
    ClipboardView()
}
