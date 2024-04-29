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
    
    @State var labColor : Color = Color.red
    
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
    }
}

private struct DefaultColorCheckView : View {
   
    @Binding var labColor : Color
    
    let defaultColors : [Color] = [Color.red , Color.orange,Color.green,Color.blue , Color.brown,Color.cyan,Color.purple,Color.gray,Color.pink , Color.yellow , Color.mint , Color.indigo]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 6) , spacing: 20) {
            ForEach(defaultColors , id: \.self ){ item in
                ColorItem(labColor: $labColor, color: item)
            }
        }
    }
}

private struct ColorItem : View {
    
    @Binding var labColor : Color
    
    let color : Color
    
    var body: some View {
        Circle()
            .fill(color)
            .overlay {
                if labColor.toHexString() == color.toHexString() {
                    Circle()
                        .stroke(.white, lineWidth: 3)
                        .padding(5)
                }
            }
            .onTapGesture {
                withAnimation {
                    self.labColor = color
                }
            }
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
