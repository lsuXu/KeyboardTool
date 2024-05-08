//
//  SettingView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var model : ClipBoardViewModel = ClipBoardViewModel.shared
    
    var body: some View {
        NavigationStack {
            List{
                Section {
                    Button {
                        model.cleanAll()
                    } label: {
                        Text("清空剪切板")
                    }

                } header: {
                    Text("剪切板")
                }

                Section {
                    Button {
                        if let bundleIdentifier = Bundle.main.bundleIdentifier ,let appSettings = URL(string: "\(UIApplication.openSettingsURLString)&path=\(bundleIdentifier)") {
                            if UIApplication.shared.canOpenURL(appSettings) {
                                UIApplication.shared.open(appSettings , options: [:])
                            }
                        }
                    } label: {
                        HStack{
                            Text("打开系统设置")
                                .font(.system(size: 14,weight: .bold))
                            Spacer()
                        }
                    }
                } footer: {
                    Text("请在设置里面添加XClip键盘")
                }

            }
            .background(.mainBg)
            .navigationTitle(Text("设置"))
        }
    }
}

#Preview {
    SettingView()
}
