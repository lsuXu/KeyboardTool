//
//  QuickTextView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import SwiftUI

struct QuickTextView: View {
    
    @EnvironmentObject var model : QuickTextViewModel
    
    @State var showAddDialog : Bool = false
    
    let group : QuickTextGroup
    
    @State var editedQuickText : QuickText? = nil
    
    var body: some View {
        Group{
            if model.groupTextMap[group.id]?.isEmpty ?? true {
                Button {
                    withAnimation {
                        showAddDialog.toggle()
                    }
                } label: {
                    Text("点击添加快捷文本")
                }

            } else {
                List {
                    ForEach(model.groupTextMap[group.id] ?? [] , id: \.id) { item in
                        Text(item.text)
                            .font(.mainTextFont)
                            .onTapGesture {
                                withAnimation {
                                    self.editedQuickText = item
                                }
                            }
                            .swipeActions(edge : .trailing , allowsFullSwipe: true) {
                                Button() {
                                    model.removeQuickText(item)
                                } label: {
                                    Text("删除")
                                }
                                .tint(Color.red)
                                
                                Button() {
                                    withAnimation {
                                        self.editedQuickText = item
                                    }
                                } label: {
                                    Text("编辑")
                                }
                                .tint(Color.blue)
                            }
                    }
//                    .onMove(perform: textMove)
                }
            }
        }
        .sheet(isPresented: $showAddDialog, content: {
            CreateQuickTextView(show: $showAddDialog, group: group)
        })
        .sheet(item: $editedQuickText, content: { quickText in
            EditQuickTextView(group: group, quickText: quickText){
                self.editedQuickText = nil
            }
        })
        .navigationTitle(Text(group.label))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        showAddDialog.toggle()
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                }

            }
        }
    }
    
    //分组移动
    func textMove(from source: IndexSet, to destination: Int) {
        
    }
}
