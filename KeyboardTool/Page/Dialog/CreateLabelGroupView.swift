//
//  CreateLabelGroupView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct CreateLabelGroupView: View {
    
    @EnvironmentObject var model : QuickTextViewModel
    
    @Binding var show : Bool
    
    @State var label : String = ""
    
    @State var labColor : Color = Color.red
    
    var body: some View {
        VStack{
            TitleView(title: "新建标签"){
                if !label.isEmpty {
                    model.createGroup(lab: label, color: labColor)
                    withAnimation {
                        show.toggle()
                    }
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
            
            
            ColorPicker(selection: $labColor, supportsOpacity: true) {
                Text("更多颜色选择")
            }
            
            DefaultColorCheckView(labColor : $labColor)
                .roundBackground(radius : 10 ,horizontal: 18 , vertical: 20)
            
            Spacer()
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 12)
        .background(.mainBg)
    }
}
