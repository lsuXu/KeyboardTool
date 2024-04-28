//
//  NavigationItemView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct NavigationItemView: View {
    
    let title : String
    
    let icon : String
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .center , spacing: 5) {
                Image(systemName: icon)
                    .renderingMode(.template)
                    .imageScale(.large)
                    .symbolRenderingMode(.monochrome)
                Text(title)
                    .font(.system(size: 11,weight: .black))
            }
            Spacer()
        }
        .padding(.top , 10)
    }
}
