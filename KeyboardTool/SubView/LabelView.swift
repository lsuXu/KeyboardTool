//
//  LabelView.swift
//  KeyboardTool
//
//  Created by jz on 2024/4/28.
//

import SwiftUI

struct LabelView: View {
    
    let label : String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        HStack{
            Text(label)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal , 18)
    }
}
