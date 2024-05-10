//
//  SettingView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var model : ClipBoardViewModel = ClipBoardViewModel.shared
    
    @AppStorage(Config.keySettingTouchClip) var keySettingTouchClip : Bool = true

    var body: some View {
        NavigationStack {
            List{
                Section {
                    Button {
                        model.cleanAll()
                    } label: {
                        Toggle("单击复制", isOn: $keySettingTouchClip)
                            .foregroundColor(.black)
                            .font(.btnTextFont)
                    }
                    Button {
                        model.cleanAll()
                    } label: {
                        Text("清空剪切板")
                            .font(.btnTextFont)
                    }

                } header: {
                    Text("剪切板")
                } footer: {
                    Text("默认单击复制，关闭后点击不会再复制文本")
                }

                Section {
                    Button {
                        if let bundleIdentifier = Bundle.main.bundleIdentifier ,let appSettings = URL(string: "\(UIApplication.openSettingsURLString)path=\(bundleIdentifier)") {
                            if UIApplication.shared.canOpenURL(appSettings) {
                                UIApplication.shared.open(appSettings , options: [:])
                            }
                        }
                    } label: {
                        HStack{
                            Text("打开系统设置")
                                .font(.btnTextFont)
                            Spacer()
                        }
                    }
                } footer: {
                    Text("请在设置里面添加XClip键盘")
                }
                
                Section {
                    VStack(alignment : .leading , spacing: 10){
                        Text("开启DIY键盘")
                            .font(.btnTextFont)
                            .foregroundStyle(.black)
                        Text("方法1:在“设置”-“DIY键盘”-“键盘”里面允许访问键盘")
                            .hintText()
                        Text("方法2:在“设置”-“通用”-“键盘”-“键盘”-“添加新键盘”里面添加DIY键盘")
                            .hintText()
                        Text("方法3:长按输入法的地图图标，进入键盘设置里面添加")
                            .hintText()
                        
                    }
                } header: {
                    Text("教程")
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
