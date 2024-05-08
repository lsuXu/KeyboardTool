//
//  AppSceneDelegate.swift
//  KeyboardTool
//
//  Created by jz on 2024/5/8.
//

import Foundation
import UIKit

open class AppSceneDelegate : NSObject ,UIWindowSceneDelegate {
    
    public func sceneDidEnterBackground(_ scene: UIScene) {
        print("APP进入后台")
    }
    
    public func sceneWillEnterForeground(_ scene: UIScene) {
        print("APP进入前台")
        ClipBoardViewModel.shared.onAppEnterToForground()
    }
    
}

