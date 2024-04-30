//
//  QuickTextGroup.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct QuickTextGroup : Codable , Identifiable {
    
    let id : Int
    //标签名字
    var label : String
    //标签颜色
    var colorHex : String
    //创建时间
    let createTime : Int
    
    init(label : String ,color : Color){
        self.label = label
        self.colorHex = color.toHexString()
        self.id = CounterTool.shared.getId("QuickTextGroup")
        self.createTime = Int(Date.now.timeIntervalSince1970)
    }
    
    func getColor() -> Color {
        Color.init(hex: colorHex)
    }
    
}
