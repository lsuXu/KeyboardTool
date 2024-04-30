//
//  QuickTextView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct QuickTextGroupView: View {
    
    @StateObject var quickGroupModel = QuickTextViewModel()
        
    @State var showAddGroup : Bool = false
    
    @State var editedGroup : QuickTextGroup? = nil
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing : 0){
                
                List {
                    
                    Section{
                        NavigationLink {
                            AllQuickTextView()
                                .environmentObject(quickGroupModel)
                        } label: {
                            HStack{
                                Text("全部")
                                    .font(.mainGroupFont)
                                Spacer()
                            }
                        }

                    }
                    .listSectionSeparator(.hidden, edges: .all)
                    .listRowBackground(Color.white)
                    
                    Section(header : HStack{
                        Text("自定义")
                        Spacer()
                    }) {
                        ForEach(quickGroupModel.allGroup , id: \.id){ item in
                            NavigationLink(destination: {
                                QuickTextView(group: item)
                                    .environmentObject(quickGroupModel)
                            }, label: {
                                HStack(spacing : 20){
                                    Circle()
                                        .fill(item.getColor())
                                        .frame(width: 16,height: 16)
                                        
                                    Text(item.label)
                                        .font(.mainGroupFont)
                                    Spacer()
                                }
                            })
                            .swipeActions(edge : .trailing , allowsFullSwipe: true) {
                                Button() {
                                    quickGroupModel.removeQuickGroup(item)
                                } label: {
                                    Text("删除")
                                }
                                .tint(Color.red)
                                
                                Button() {
                                    withAnimation {
                                        self.editedGroup = item
                                    }
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
            .sheet(isPresented: $showAddGroup, content: {
                CreateLabelGroupView(show: $showAddGroup)
                    .environmentObject(quickGroupModel)
            })
            .sheet(item: $editedGroup, content: { group in
                EditQuickGroupView(group: group) {
                    self.editedGroup = nil
                }
                .environmentObject(quickGroupModel)
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
    QuickTextGroupView()
}
