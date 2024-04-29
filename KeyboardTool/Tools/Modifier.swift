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
    
    let horizontal : CGFloat
    
    let vertical : CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal , horizontal)
            .padding(.vertical , vertical)
            .background(RoundedRectangle(cornerRadius: radius).fill(bgColor))
    }
}
