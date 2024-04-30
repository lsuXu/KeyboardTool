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
    
    func toHexString() -> String {
        let components = UIColor(self).cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
 
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}


extension Dictionary {
    
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(
            withJSONObject: self,options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
    }
    
}



extension Font {
    static let keyboardText : Font = .system(size: 14,weight: .bold)
    //主要的文本字体
    static let mainTextFont : Font = .system(size: 13,weight: .bold)
    
    static let mainGroupFont : Font = .system(size: 14,weight: .bold)

    static let subLabelFont : Font = .system(size: 13,weight: .light)
}


extension View {
    func roundBackground(radius : CGFloat = 8 , color : Color = .white , horizontal : CGFloat = 18, vertical : CGFloat = 12) -> some View {
        self.modifier(RoundBgModify(radius: radius, bgColor: color,horizontal: horizontal , vertical: vertical))
    }
}


extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        super.viewWillLayoutSubviews()
    }
    
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        print("解码 result = \(result)")
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("解码 rawValue result = \(result)")
        return result
    }
}
