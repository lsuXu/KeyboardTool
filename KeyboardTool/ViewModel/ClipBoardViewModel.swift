//
//  CuttingBoardViewModel.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/30.
//

import SwiftUI

open class ClipBoardViewModel : ObservableObject {
    
    let clipBoardCacheKey = "clipBoardCacheKey"

    @Published var clipInfos : [ClipboardInfo] = []
    
    init() {
        self.clipInfos = clipInfos
    }
    
    //添加剪切板数据
    func addClipboardInfo(_ text : String) {
        let clipInfo = ClipboardInfo(text: text)
        clipInfos.insert(clipInfo, at: 0)
        cacheClipBoard(clipInfos)
    }
    
    //删除剪切板数据
    func deleteClipboardInfo(_ clipInfo : ClipboardInfo) {
        clipInfos.removeAll { info in
            info.id == clipInfo.id
        }
        cacheClipBoard(clipInfos)
    }
    
    //存储ClipboardInfo数据
    func cacheClipBoard(_ clipInfos : [ClipboardInfo]) {
        do {
            let encodedData = try JSONEncoder().encode(clipInfos)
            getShared()?.set(encodedData, forKey: clipBoardCacheKey)
        } catch {
            print("保存失败群组，Error encoding QuickTextGroups to JSON: \(error)")
        }
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
