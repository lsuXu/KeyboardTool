//
//  AllQuickTextView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct AllQuickTextView: View {
    
    @EnvironmentObject var model : QuickTextViewModel
    
    @State var editQuickText : QuickText?
    
    @State var showAddDialog : Bool = false
    
    var body: some View {
        Group{
            if model.allText.isEmpty {
                Text("快捷文本还没有设置")
            } else {
                List {
                    ForEach(model.allText){ quickText in
                        Button {
                            withAnimation {
                                self.editQuickText = quickText
                            }
                        } label: {
                            let group = model.getGroup(quickText.groupId)
                            VStack(alignment : .leading) {
                                Text(quickText.text)
                                    .font(.system(size: 13,weight: .bold))
                                HStack(spacing : 15){
                                    Spacer()
                                    Text(group?.label ?? "")
                                        .font(.subLabelFont)
                                    Circle()
                                        .fill(group?.getColor() ?? .red)
                                        .frame(width: 8 , height: 8)
                                }
                            }
                        }

                    }
                }
            }
        }
//        .sheet(isPresented: $showAddDialog, content: {
//            CreateQuickTextView(show: $showAddDialog, group: group)
//        })
        .sheet(item: $editQuickText) { quickText in
            if let group = model.getGroup(quickText.groupId) {
                EditQuickTextView(group: group, quickText: quickText) {
                    self.editQuickText = nil
                }
            }
        }
        .navigationTitle(Text("全部"))
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    withAnimation {
//                        showAddDialog.toggle()
//                    }
//                } label: {
//                    Image(systemName: "plus.circle.fill")
//                }
//            }
//        }
    }
}

#Preview {
    AllQuickTextView()
}
