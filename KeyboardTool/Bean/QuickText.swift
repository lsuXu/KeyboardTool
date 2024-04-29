//
//  QuickText.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import Foundation

struct QuickText : Decodable , Encodable {
    
    let id : Int
    
    let createTime : Int
    
    let text : String
    
    let groupId : Int
    
    init(text: String, groupId: Int) {
        self.id = CounterTool.shared.getId("QuickText")
        self.createTime = Int(Date.now.timeIntervalSince1970)
        self.text = text
        self.groupId = groupId
    }
}
