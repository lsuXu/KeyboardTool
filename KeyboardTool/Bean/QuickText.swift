//
//  QuickText.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import Foundation

struct QuickText : Codable , Identifiable {
    
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
    
    private init(id : Int , createTime : Int ,text: String, groupId: Int){
        self.id = id
        self.createTime = createTime
        self.text = text
        self.groupId = groupId
    }
    
    func modify(text : String) -> QuickText {
        QuickText(id: self.id, createTime: self.createTime, text: text, groupId: self.groupId)
    }
}
