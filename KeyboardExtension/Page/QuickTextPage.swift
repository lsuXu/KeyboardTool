//
//  QuickTextPage.swift
//  KeyboardExtension
//
//  Created by jz on 2024/5/7.
//

import SwiftUI

struct QuickTextPage: View {
    @EnvironmentObject var model : QuickTextViewModel
    
    @State var selectedGroup : QuickTextGroup? = nil
    
    let onTextClick : (_ text : String) -> Void
    
    var body: some View {
        HStack{
            VStack{
                ScrollView {
                    VStack{
                        ForEach(model.allGroup , id: \.id){ group in
                            HStack(spacing: 6){
                                Circle()
                                    .fill(group.getColor())
                                    .frame(width: 8, height: 8)
                                Text(group.label)
                                    .font(.normalText)
                                    .lineLimit(2)
                                Spacer()
                            }
                            .roundBackground(color : group.id == selectedGroup?.id ? .white : .mainColor)
                            .onTapGesture {
                                withAnimation {
                                    selectedGroup = group
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.25)

            ScrollView {
                VStack{
                    if let currGroup = self.selectedGroup , let childs = model.groupTextMap[currGroup.id] {
                        ForEach(childs , id: \.id){ quickText in
                            HStack(spacing: 3){
                                Text(quickText.text)
                                    .font(.normalText)
                                Spacer()
                            }
                            .roundBackground(color : .mainColor)
                            .onTapGesture {
                                onTextClick(quickText.text)
                            }
                        }
                    }
                    HStack{
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            self.selectedGroup = model.allGroup.first
        }
    }
    
}
