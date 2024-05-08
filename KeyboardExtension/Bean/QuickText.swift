//
//  QuickText.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/7.
//

import Foundation

struct QuickText : Codable , Identifiable {
    
    let id : Int
    
    let createTime : Int
    
    let text : String
    
    let groupId : Int
    
    init(id : Int , createTime : Int ,text: String, groupId: Int){
        self.id = id
        self.createTime = createTime
        self.text = text
        self.groupId = groupId
    }
    
    func modify(text : String) -> QuickText {
        QuickText(id: self.id, createTime: self.createTime, text: text, groupId: self.groupId)
    }
}
