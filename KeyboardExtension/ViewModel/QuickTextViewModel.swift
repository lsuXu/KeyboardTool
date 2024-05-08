//
//  QuickTextViewModel.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/7.
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

   

    // 检索 QuickTextGroup 数组
    func loadGroups() -> [QuickTextGroup] {
        if let encodedData = getShared()?.data(forKey: groupCacheKey) {
            do {
                let str = String(data: encodedData, encoding: .utf8)
                let decodedGroups = try JSONDecoder().decode([QuickTextGroup].self, from: encodedData)
                return decodedGroups
            } catch {
                print("Error decoding QuickTextGroups from JSON: \(error)")
            }
        }
        return []
    }

    // 检索 QuickTextGroup 数组
    func loadQuickText() -> [QuickText] {
        if let encodedData = getShared()?.data(forKey: quickTextCacheKey) {
            let str = String(data: encodedData, encoding: .utf8)
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
    
  
}
