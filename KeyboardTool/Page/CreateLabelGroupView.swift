//
//  CreateLabelGroupView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct CreateLabelGroupView: View {
    
    @Binding var show : Bool
    
    @State var label : String = ""
    
    @State var labColor : Color = .white
    
    var body: some View {
        VStack{
            TitleView(show: $show)
            
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
                ColorPicker("", selection: $labColor)
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 2), count: 6)) {
                ForEach(0..<33 ){ item in
                    Text("\(item)")
                }
            }
            .roundBackground()
            
            Spacer()
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 12)
        .background(.mainBg)
    }
}


private struct TitleView : View {
    
    @Binding var show : Bool

    var body: some View {
        HStack{
            Spacer()
            Text("新建标签")
                .font(.title2)
            Spacer()
        }
        .overlay(alignment: .trailing) {
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Text("完成")
                    .font(.title3)
            }
        }
    }
}
