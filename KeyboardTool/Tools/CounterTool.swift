//
//  CounterTool.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/29.
//

import Foundation


class CounterTool {
    
    static let shared = CounterTool()
    
    let cacheKey : String = "CountKey"
    
    let defaults: UserDefaults
    
    var counter : [String : Int] = [:] {
        didSet {
            defaults.set(counter, forKey: cacheKey)
        }
    }

    init() {
        self.defaults = UserDefaults.standard
        self.counter = UserDefaults.standard.dictionary(forKey: cacheKey) as? [String : Int] ?? [:]
    }
    
    func getId(_ key : String) -> Int{
        if let id = counter[key] {
            let result = id + 1
            counter[key] = result
            return result
        } else {
            counter[key] = 1
            return 1
        }
    }
}
