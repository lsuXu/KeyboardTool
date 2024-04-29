//
//  DataCache.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import Foundation

open class QuickTextViewModel : ObservableObject {
        
    @Published var quickGroups : [QuickTextGroup] = []
    
    @Published var quickTexts : [Int : QuickText] = [:]
    
    init() {
        
//        UserDefaults(suiteName: Config.extensionGroup)
//            ?.array(forKey: <#T##String#>)
    }
}
