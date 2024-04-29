//
//  QuickTextView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct QuickTextView: View {
    
    let data : [Int] = [1,2,3,4,5,6,7]
    
    @State var showAddGroup : Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing : 0){
                
                List {
                    
                    Section{
                        HStack{
                            Text("全部")
                                .font(.system(size: 14,weight: .bold))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .listSectionSeparator(.hidden, edges: .all)
                    .listRowBackground(Color.white)
                    
                    Section(header : HStack{
                        Text("自定义")
                        Spacer()
                    }) {
                        ForEach(data , id: \.self){ item in
                            HStack(spacing : 20){
                                Circle()
                                    .fill(.red)
                                    .frame(width: 16,height: 16)
                                    
                                Text("全部")
                                    .font(.system(size: 14,weight: .bold))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .swipeActions(edge : .trailing , allowsFullSwipe: true) {
                                Button() {
                                    print("删除")
                                } label: {
                                    Text("删除")
                                }
                                .tint(Color.red)
                                
                                Button() {
                                    print("编辑")
                                } label: {
                                    Text("编辑")
                                }
                                .tint(Color.blue)
                            }
                        }
                    }
                    .listSectionSeparator(.hidden, edges: .top)
                    .listRowBackground(Color.white)
                    
                }
                .listStyle(.insetGrouped)
                .background(.mainBg)
                
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(Text("快捷文本"))
            .sheet(isPresented: $showAddGroup, onDismiss: {
                print("隐藏了")
            }, content: {
                CreateLabelGroupView(show: $showAddGroup)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            showAddGroup.toggle()
                        }
                    } label: {
                        Image(systemName: "folder.badge.plus")
                    }

                }
            }
        }
    }
}

#Preview {
    QuickTextView()
}
