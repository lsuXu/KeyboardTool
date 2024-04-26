//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by jz on 2024/4/24.
//

import UIKit
import SwiftUI

private var appURLString = "KeyboardTool://"
private let groupName = "group.dev.tools"

class KeyboardViewController: UIInputViewController {

    
    @IBOutlet var nextKeyboardButton: UIButton!

        
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.inputView = MyInputView()
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        
        let hostView = UIHostingController(rootView: CustomerInputView(proxy: self.textDocumentProxy){
            self.openMainApp()
        }).view
        hostView?.translatesAutoresizingMaskIntoConstraints = false
        
        let delBtn = UIButton(type: .infoDark)
        delBtn.translatesAutoresizingMaskIntoConstraints = false
        
        if let hostView = hostView ,let inputView = self.inputView{
            inputView.addSubview(hostView)
            inputView.addSubview(delBtn)
            
            // 设置图片视图的约束
            NSLayoutConstraint.activate([
                hostView.topAnchor.constraint(equalTo: inputView.topAnchor),
                hostView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
                hostView.trailingAnchor.constraint(equalTo: inputView.trailingAnchor),
                hostView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
                delBtn.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
                delBtn.leftAnchor.constraint(equalTo: inputView.leftAnchor)
            ])
        }
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    

    private func openMainApp() {
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: { _ in
            guard let url = URL(string: appURLString) else { return }
            _ = self.openURL(url)
        })
    }
    
    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        
        return false
    }
}

class MyInputView : UIInputView {
    
  
}

struct CustomerInputView : View {
    
    @State var selctedTab : Int = 1
    
    let proxy : UITextDocumentProxy
    
    let launchApp : ()-> Void
    
    var body: some View {
        VStack{
            HStack{
                HStack(){
                    MenuItem(tag: 1, text: "快捷文本", checkedTag: $selctedTab)
                    MenuItem(tag: 2, text: "剪切板", checkedTag: $selctedTab)
                    MenuItem(tag: 3, text: "计算器", checkedTag: $selctedTab)
                }
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.menuBgColor))
                
                Image(systemName: "seal")
                    .imageScale(.small)
                    .padding(.horizontal , 15)
                    .onTapGesture {
                        launchApp()
                    }
            }
            
            GeometryReader(content: { geometry in
                TabView(selection: $selctedTab,
                        content:  {
                    ScrollView {
                        VStack{
                            
                            Text("Tab1")
                            Text("Tab1")
                            Text("Tab1")
                            Text("Tab1")
                        }
                    }
                    .tag(1)
                    ScrollView {
                        VStack{
                            Text("给大家啊多久啊")
                            Text("给大家啊多久啊")
                            Text("给大家啊多久啊")
                            Text("给大家啊多久啊")
                                .onTapGesture {
                                    proxy.setMarkedText("你好啊", selectedRange: NSRange.init(location: 0, length: 0))
                                }
                        }
                    }
                    .tag(2)
                    ScrollView {
                        VStack{
                            Text("Tab333")
                            Text("给大家啊多久啊Tab333")
                            Text("给大家啊多久啊Tab333")
                            Text("给大家啊多久啊Tab333")
                                .onTapGesture {
                                    proxy.setMarkedText("你好啊", selectedRange: NSRange.init(location: 0, length: 0))
                                }
                        }
                    }
                    .tag(3)
                })
                .frame(width: geometry.size.width , height: geometry.size.height)
            })
            HStack{
                
                Spacer()
                BtnItem(text: "add"){
                    //插入一个字符
                    proxy.insertText("我")
                }
                BtnItem(text: "删除"){
                    //删除一个字符
                    proxy.deleteBackward()
                }
                Spacer()
            }

        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width,height: 300)
        .background(Color.bgColor)
    }
    
}

struct BtnItem : View {
    
    let text : String
    
    let action : () -> Void
    
    var body: some View {
        HStack{
            Button {
                action()
            } label: {
                Text(text)
                    .font(.system(size: 14,weight: .bold))
            }

        }
        .padding(.horizontal , 20)
        .padding(.vertical , 10)
        .background(RoundedRectangle(cornerRadius: 5).fill(Color.mainColor))
    }
}

struct MenuItem : View {
    
    let tag : Int
    
    let text : String
    
    @Binding var checkedTag : Int
    
    var body: some View {
        HStack{
            Spacer()
            Text(text)
                .font(.keyboardText)
            Spacer()
        }
        .padding(.vertical , 8)
        .background{
            if checkedTag == tag {
                RoundedRectangle(cornerRadius: 5).fill(Color.white)
            }
        }
        .onTapGesture {
            withAnimation {
                checkedTag = tag
            }
        }
    }
}
