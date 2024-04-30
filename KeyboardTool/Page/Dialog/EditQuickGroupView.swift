//
//  EditQuickGroupView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct EditQuickGroupView: View {
    @EnvironmentObject var model : QuickTextViewModel
        
    @State var label : String = ""
    
    @State var labColor : Color = Color.red
    
    let group : QuickTextGroup
    
    let onFinish : () -> Void
    
    var body: some View {
        VStack{
            TitleView(title: "修改标签"){
                if !label.isEmpty {
                    model.modifyGroup(lab: label, color: labColor, groupId: group.id)
                    onFinish()
                }
            }
            
            LabelView("标签")
            
            HStack{
                Circle()
                    .fill(labColor)
                    .frame(width: 16,height: 16)
                TextField("", text: $label, axis: .horizontal)
            }
            .roundBackground()
            
            LabelView("标签颜色")
                .padding(.top , 20)
            
            
            HStack{
                ColorPicker("", selection: $labColor ,supportsOpacity: false)
                Spacer()
            }
            
            DefaultColorCheckView(labColor : $labColor)
                .roundBackground(radius : 10 ,horizontal: 18 , vertical: 20)
            
            Spacer()
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 12)
        .background(.mainBg)
        .onAppear {
            self.labColor = group.getColor()
            self.label = group.label
        }
    }
}
