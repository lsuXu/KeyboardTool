//
//  ClipBoardViewModel.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/8.
//

import SwiftUI

open class ClipBoardViewModel : NSObject , ObservableObject {
    
    static let shared : ClipBoardViewModel = ClipBoardViewModel()
        
    let clipBoardCacheKey = "clipBoardCacheKey"

    @Published var clipInfos : [ClipboardInfo] = []
    
    override init() {
        super.init()
        self.clipInfos = loadClipBoards()
        addListener()
    }
    
    deinit {
        removeListener()
    }

    //加载ClipboardInfo数据
    func loadClipBoards() -> [ClipboardInfo] {
        if let encodedData = getShared()?.data(forKey: clipBoardCacheKey) {
            do {
                let clips = try JSONDecoder().decode([ClipboardInfo].self, from: encodedData)
                return clips
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
            userDefault.addObserver(self, forKeyPath: clipBoardCacheKey, context: nil)
        }
    }
    
    func removeListener(){
        if let userDefault = getShared() {
            userDefault.removeObject(forKey: clipBoardCacheKey)
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == clipBoardCacheKey {
            //快捷文本数据变化
            self.clipInfos = loadClipBoards()
        }
    }
}
