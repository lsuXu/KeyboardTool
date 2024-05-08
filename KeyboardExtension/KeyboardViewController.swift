//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by jz on 2024/4/24.
//

import UIKit
import SwiftUI

private var appURLString = "XKeyboard://"
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
        } onTextClick: { text in
            self.onTextClick(text)
        }).view
        hostView?.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let hostView = hostView ,let inputView = self.inputView{
            inputView.addSubview(hostView)
            
            // 设置图片视图的约束
            NSLayoutConstraint.activate([
                hostView.topAnchor.constraint(equalTo: inputView.topAnchor),
                hostView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
                hostView.trailingAnchor.constraint(equalTo: inputView.trailingAnchor),
                hostView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
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
    
    func onTextClick(_ text : String) {
        self.textDocumentProxy.insertText(text)
    }
}

class MyInputView : UIInputView {
    
  
}

struct CustomerInputView : View {
    
    let quickModel : QuickTextViewModel = QuickTextViewModel()
    
    @State var selctedTab : Int = 1
    
    let proxy : UITextDocumentProxy
    
    let launchApp : ()-> Void
    
    let onTextClick : (_ text : String) -> Void
    
    var body: some View {
        VStack(spacing : 5){
            HStack{
                HStack(){
                    MenuItem(tag: 1, text: "快捷文本", checkedTag: $selctedTab)
                    MenuItem(tag: 2, text: "剪切板", checkedTag: $selctedTab)
//                    MenuItem(tag: 3, text: "计算器", checkedTag: $selctedTab)
                }
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.menuBgColor))
                
                Image(systemName: "gear")
                    .imageScale(.small)
                    .padding(.horizontal , 15)
                    .onTapGesture {
                        launchApp()
                    }
            }
            .padding(.bottom , 10)
            
            GeometryReader(content: { geometry in
                TabView(selection: $selctedTab,
                        content:  {
                    QuickTextPage(onTextClick: self.onTextClick)
                        .environmentObject(quickModel)
                        .tag(1)
                    ClipTextPage(onTextClick: self.onTextClick)
                        .tag(2)
//                    QuickTextPage(onTextClick: self.onTextClick)
//                        .environmentObject(quickModel)
//                        .tag(3)
                })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(.clear)
                .frame(width: geometry.size.width , height: geometry.size.height)
            })
            HStack(spacing : 8){
                BtnItem {
                    Text("清空输入")
                        .font(.normalText)
                        .foregroundStyle(.black)
                } action: {
                    clearText()
                }
                
                BtnItem {
                    Image(systemName: "delete.backward")
                        .imageScale(.small)
                        .foregroundStyle(.black)
                } action: {
                    //删除一个字符
                    proxy.deleteBackward()
                }

                BtnItem {
                    HStack{
                        Spacer()
                        Text("空格")
                            .font(.normalText)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                } action: {
                    //删除一个字符
                    insertSpace()
                }

                BtnItem(bgColor : .blue) {
                    Image(systemName: "return.left")
                        .imageScale(.small)
                        .foregroundStyle(.white)
                        
                } action: {
                    //删除一个字符
                    insertNewline()
                }
            }
            
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width,height: 300)
        .background(Color.bgColor)
    }
    
    func clearText() {
        // 循环删除文本直到输入文本为空
        while proxy.hasText {
            proxy.deleteBackward()
        }
    }
    
    //输入空格
    func insertSpace() {
        proxy.insertText(" ")
    }

    //输入换行符
    func insertNewline() {
        proxy.insertText("\n")
    }
    
}


struct BtnItem<Label> : View where Label : View {
    
    let bgColor : Color
            
    let child : () -> Label
    
    let action : () -> Void
    
    init(bgColor: Color = .mainColor, child: @escaping () -> Label, action: @escaping () -> Void) {
        self.bgColor = bgColor
        self.child = child
        self.action = action
    }
    
    var body: some View {
        HStack{
            Button {
                action()
            } label: {
                child()
            }

        }
        .padding(.horizontal , 20)
        .padding(.vertical , 10)
        .background(RoundedRectangle(cornerRadius: 5).fill(bgColor))
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
