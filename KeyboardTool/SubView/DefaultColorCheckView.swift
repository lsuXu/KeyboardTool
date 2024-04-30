//
//  DefaultColorCheckView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct DefaultColorCheckView: View {
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
