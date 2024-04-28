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
            VStack{
                ScrollView {
                    VStack{
                        HStack{
                            Text("全部")
                                .font(.system(size: 14,weight: .bold))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .roundBackground()
                        
                        HStack{
                            Text("自定义")
                                .font(.system(size: 12))
                                .foregroundStyle(.blue)
                                .padding(.horizontal , 18)
                                .padding(.top , 30)
                            Spacer()
                        }
                        
                        LazyVStack {
                            ForEach(data , id: \.self){ item in
                                VStack{
                                    HStack(spacing : 20){
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 16,height: 16)
                                            
                                        Text("全部")
                                            .font(.system(size: 14,weight: .bold))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding(.vertical , 8)
                                    Divider()
                                }
                            }
                        }
                        .roundBackground()
                        
                    }
                    .padding(.horizontal , 20)
                
                }
            }
            .background(.mainBg)
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
