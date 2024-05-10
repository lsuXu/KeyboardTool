//
//  BaseModel.swift
//  KeyboardTool
//
//  Created by jz on 2024/5/9.
//

import SwiftUI

open class BaseModel : ObservableObject {
    
    @Published var showToast : Bool = false
    
    @Published var toastMsg : String = ""
    
    func showToast(_ msg : String) {
        withAnimation {
            showToast = true
            toastMsg = msg
        }
    }
}
