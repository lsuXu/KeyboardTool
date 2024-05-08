//
//  ClipboardInfo.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/8.
//

import SwiftUI

struct ClipboardInfo : Codable {
    
    let id : Int
    
    let createTime : Int
    
    let text : String
    
    init(id: Int, createTime: Int, text: String) {
        self.id = id
        self.createTime = createTime
        self.text = text
    }
}
