//
//  DataCache.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import Foundation
import SwiftUI

open class QuickTextViewModel : ObservableObject {
        
    @Published var allGroup : [QuickTextGroup] = []
    
    @Published var allText : [QuickText] = []
    
    //分组文本
    @Published var groupTextMap : [Int : [QuickText]] = [:]
    
    let groupCacheKey = "GroupCacheDataKey"

    let quickTextCacheKey = "QuickTextCacheDataKey"

    init() {
        let groups = loadGroups()
        let texts = loadQuickText()
        self.allGroup = groups
        self.allText = texts
        self.groupTextMap = updateQuickGroupMap(allGroup: groups, allText: texts)
    }
    
    func getGroup(_ groupId : Int) -> QuickTextGroup? {
        allGroup.first { group in
            group.id == groupId
        }
    }
    
    private func updateQuickGroupMap(allGroup : [QuickTextGroup],allText : [QuickText]) -> [Int : [QuickText]]{
        var groups : [Int : [QuickText]] = allGroup.enumerated().reduce(into: [:]) { partialResult, ele in
            partialResult[ele.element.id] = []
        }
        allText.forEach { item in
            groups[item.groupId]?.append(item)
        }
        return groups
    }
    
    //添加快捷文本
    func createQuickText(text : String , groupId : Int){
        let quickText = QuickText(text: text, groupId: groupId)
        insertQuickText(quickText)
        if var group = groupTextMap[quickText.groupId] {
            group.append(quickText)
            groupTextMap[quickText.groupId] = group
        } else {
            groupTextMap[quickText.groupId] = [quickText]
        }
        
    }
    
    //添加快捷文本分组
    func createGroup(lab : String , color : Color){
        let group = QuickTextGroup(label: lab, color: color)
        self.insertGroup(group)
    }
    
    //更新分组信息
    func modifyGroup(lab : String , color : Color , groupId : Int){
        if let index = allGroup.firstIndex(where: { group in
            group.id == groupId
        }){
            var currGroup = allGroup.remove(at: index)
            currGroup.label = lab
            currGroup.colorHex = color.toHexString()
            insertGroup(currGroup)
        }
    }
    
    
    //更新快捷文本信息
    func modifyTextLabel(text : String , labId : Int){
        if let index = allText.firstIndex(where: { item in
            item.id == labId
        }){
            let newQuickText = allText.remove(at: index).modify(text: text)
            insertQuickText(newQuickText)
            
            if var showGroup = groupTextMap[newQuickText.groupId] , let childIndex = showGroup.firstIndex(where: { item in
                item.id == newQuickText.id
            }){
                showGroup.remove(at: childIndex)
                showGroup.insert(newQuickText, at: 0)
                groupTextMap[newQuickText.groupId] = showGroup
            }
        }
    }
    
    //移除快捷文本
    func removeQuickText(_ item : QuickText){
        deleteQuickText(item)
        if var group = groupTextMap[item.groupId] {
            group.removeAll { text in
                text.id == item.id
            }
            groupTextMap[item.groupId] = group
        }
    }
    
    //移除快捷分组
    func removeQuickGroup(_ item : QuickTextGroup){
        //移除分组
        deleteGroup(item)
        //根据groupId移除快捷文本
        deleteQuickTextByGroupId(item.id)
        //移除群信息
        groupTextMap.removeValue(forKey: item.id)
    }
    
    // 存储 QuickTextGroup 数组
    func saveGroups(_ groups: [QuickTextGroup]) {
        do {
            let encodedData = try JSONEncoder().encode(groups)
            print("保存群组数据：\(groups.count)")
            getShared()?.set(encodedData, forKey: groupCacheKey)
        } catch {
            print("保存失败群组，Error encoding QuickTextGroups to JSON: \(error)")
        }
    }

    // 检索 QuickTextGroup 数组
    func loadGroups() -> [QuickTextGroup] {
        if let encodedData = getShared()?.data(forKey: groupCacheKey) {
            do {
                let str = String(data: encodedData, encoding: .utf8)
                print("loadQuickTextGroups解码数据：\(str)")
                let decodedGroups = try JSONDecoder().decode([QuickTextGroup].self, from: encodedData)
                return decodedGroups
            } catch {
                print("Error decoding QuickTextGroups from JSON: \(error)")
            }
        }
        return []
    }
    
    // 存储 QuickTextGroup 数组
    func saveQuickText(_ texts: [QuickText]) {
        do {
            print("保存文本数据：\(texts.count)")
            let encodedData = try JSONEncoder().encode(texts)
            getShared()?.set(encodedData, forKey: quickTextCacheKey)
        } catch {
            print("保存失败文本 Error encoding QuickTextGroups to JSON: \(error)")
        }
    }

    // 检索 QuickTextGroup 数组
    func loadQuickText() -> [QuickText] {
        if let encodedData = getShared()?.data(forKey: quickTextCacheKey) {
            let str = String(data: encodedData, encoding: .utf8)
            print("loadQuickText解码数据：\(str)")
            do {
                let decodedGroups = try JSONDecoder().decode([QuickText].self, from: encodedData)
                return decodedGroups
            } catch {
                print("Error decoding QuickTextGroups from JSON: \(error)")
            }
        }
        return []
    }
    
    func getShared() -> UserDefaults? {
        UserDefaults(suiteName: Config.extensionGroup)
    }
    
    //插入快捷文本
    private func insertQuickText(_ item : QuickText) {
        allText.insert(item, at: 0)
        saveQuickText(allText)
    }
    
    //删除快捷文本
    private func deleteQuickText(_ item : QuickText) {
        allText.removeAll { quick in
            quick.id == item.id
        }
        saveQuickText(allText)
    }
    
    //根据分组删除快捷文本
    private func deleteQuickTextByGroupId(_ groupId : Int) {
        //移除快捷文本
        allText.removeAll { child in
            groupId == child.groupId
        }
        saveQuickText(allText)
    }
    
    //插入分组
    private func insertGroup(_ item : QuickTextGroup) {
        allGroup.insert(item, at: 0)
        saveGroups(allGroup)
    }
    
    //删除分组
    private func deleteGroup(_ item : QuickTextGroup) {
        allGroup.removeAll { group in
            group.id == item.id
        }
        saveGroups(allGroup)
    }
}
