//
//  AppDelegate.swift
//  KeyboardTool
//
//  Created by jz on 2024/5/8.
//

import Foundation
import UIKit

class AppDelegate : NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        let configuration = UISceneConfiguration(
            name: connectingSceneSession.configuration.name,
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = AppSceneDelegate.self
        return configuration
    }
    
    
}
