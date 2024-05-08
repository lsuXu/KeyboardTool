//
//  ClipBoardViewModel.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/8.
//

import SwiftUI

open class ClipBoardViewModel : ObservableObject {
    
    static let shared : ClipBoardViewModel = ClipBoardViewModel()
        
    let clipBoardCacheKey = "clipBoardCacheKey"

    @Published var clipInfos : [ClipboardInfo] = []
    
    init() {
        self.clipInfos = loadClipBoards()
    }

    //加载ClipboardInfo数据
    func loadClipBoards() -> [ClipboardInfo] {
        if let encodedData = getShared()?.data(forKey: clipBoardCacheKey) {
            do {
                let str = String(data: encodedData, encoding: .utf8)
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
}
