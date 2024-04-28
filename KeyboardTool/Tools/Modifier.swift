//
//  Modifier.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import Foundation
import SwiftUI

struct RoundBgModify : ViewModifier {
    
    let radius : CGFloat
    
    let bgColor : Color
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal , 18)
            .padding(.vertical , 12)
            .background(RoundedRectangle(cornerRadius: radius).fill(bgColor))
    }
}
