//
//  SettingView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView {
                    VStack{
                        Button {
                            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                if UIApplication.shared.canOpenURL(appSettings) {
                                    UIApplication.shared.open(appSettings)
                                }
                            }
                        } label: {
                            HStack{
                                Text("打开系统设置")
                                    .font(.system(size: 14,weight: .bold))
                                Spacer()
                            }
                            .roundBackground()
                        }

                    }
                    .padding(.horizontal , 20)
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
