//
//  ClipboardInfo.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

struct ClipboardInfo : Codable {
    
    let id : Int
    
    let createTime : Int
    
    let text : String
    
    init(text: String) {
        self.id = CounterTool.shared.getId("ClipboardInfo")
        self.createTime = Int(Date.now.timeIntervalSince1970)
        self.text = text
    }
}
