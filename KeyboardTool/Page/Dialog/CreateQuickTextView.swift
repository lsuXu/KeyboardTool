//
//  CreateQuickTextView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct CreateQuickTextView: View {
    @EnvironmentObject var model : QuickTextViewModel
    
    @Binding var show : Bool
    
    let group : QuickTextGroup
    
    @State var text : String = ""
        
    var body: some View {
        VStack(spacing : 30){
            TitleView(title: "新建快捷文本"){
                if !text.isEmpty {
                    model.createQuickText(text: text, groupId: group.id)
                    withAnimation {
                        show.toggle()
                    }
                }
            }
            
            TextEditor(text: $text)
                .frame(height: 100)
                .roundBackground(radius: 10,horizontal: 18,vertical: 5)
                .overlay(alignment: .topLeading) {
                    if text.isEmpty {
                        Text("请输入快捷文本")
                            .font(.footnote)
                            .padding(.horizontal , 23)
                            .padding(.vertical , 15)
                    }
                }

            HStack{
                Text("标签")
                    .font(.headline)
                Spacer()
                Circle()
                    .fill(group.getColor())
                    .frame(width: 16,height: 16)
                
                Text(group.label)
            }
            .roundBackground()
                        
            Spacer()
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 12)
        .background(.mainBg)
    }
}
