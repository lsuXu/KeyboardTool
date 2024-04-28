//
//  ContentView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TabView{
                QuickTextView()
                    .tabItem({
                        NavigationItemView(title: "快捷文本", icon: "list.triangle")
                    })
                CuttingBoardView()
                    .tabItem({
                        NavigationItemView(title: "剪切板", icon: "list.clipboard")
                    })
                SettingView()
                    .tabItem({
                        NavigationItemView(title: "设置", icon: "gear")
                    })
            }
            .background(.mainBg)
        }
    }
}

