//
//  QuickTextGroup.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import Foundation

struct QuickTextGroup : Decodable , Encodable {
    
    let id : Int
    //标签名字
    let label : String
    //标签颜色
    let color : String
    //创建时间
    let createTime : Int
    
    init(label : String ,color : String){
        self.label = label
        self.color = color
        self.id = CounterTool.shared.getId("QuickTextGroup")
        self.createTime = Int(Date.now.timeIntervalSince1970)
    }
    
    init(dic : NSDictionary){
        self.id = dic["id"] as? Int ?? 0
        self.label = dic["label"] as? String ?? ""
        self.color = dic["color"] as? String ?? ""
        self.createTime = dic["createTime"] as? Int ?? 0
    }
}
