//
//  QuickTextViewModel.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/7.
//

import Foundation
import SwiftUI

open class QuickTextViewModel : NSObject , ObservableObject {
    
    @Published var allGroup : [QuickTextGroup] = []
    
    @Published var allText : [QuickText] = []
    
    //分组文本
    @Published var groupTextMap : [Int : [QuickText]] = [:]
    
    let groupCacheKey = "GroupCacheDataKey"
    
    let quickTextCacheKey = "QuickTextCacheDataKey"
    
    override init() {
        super.init()
        let groups = loadGroups()
        let texts = loadQuickText()
        self.allGroup = groups
        self.allText = texts
        self.groupTextMap = updateQuickGroupMap(allGroup: groups, allText: texts)
        addListener()
    }
    
    deinit {
        removeListener()
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
    
    func addListener(){
        if let userDefault = getShared() {
            userDefault.addObserver(self, forKeyPath: quickTextCacheKey, context: nil)
            userDefault.addObserver(self, forKeyPath: groupCacheKey, context: nil)
        }
    }
    
    func removeListener(){
        if let userDefault = getShared() {
            userDefault.removeObject(forKey: groupCacheKey)
            userDefault.removeObject(forKey: quickTextCacheKey)
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == quickTextCacheKey {
            //快捷文本数据变化
            self.allGroup = loadGroups()
        } else if keyPath == groupCacheKey {
            //分组数据变化
            let texts = loadQuickText()
            self.allText = texts
            self.groupTextMap = updateQuickGroupMap(allGroup: self.allGroup, allText: texts)
        }
    }
}
