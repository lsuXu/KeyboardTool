//
//  QuickTextGroup.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/7.
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
    
    init(id: Int, label: String, colorHex: String, createTime: Int) {
        self.id = id
        self.label = label
        self.colorHex = colorHex
        self.createTime = createTime
    }
    
    func getColor() -> Color {
        Color.init(hex: colorHex)
    }
    
}
