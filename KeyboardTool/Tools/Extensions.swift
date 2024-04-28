//
//  Extensions.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

extension Color {
    
    static let bgColor = Color(hex: "#D1D3DB")
    
    static let menuBgColor = Color(hex: "#C6C8CD")

    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


extension Font {
    static let keyboardText : Font = .system(size: 14,weight: .bold)
}


extension View {
    func roundBackground(radius : CGFloat = 8 , color : Color = .white) -> some View {
        self.modifier(RoundBgModify(radius: radius, bgColor: color))
    }
}


extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        super.viewWillLayoutSubviews()
    }
    
}
