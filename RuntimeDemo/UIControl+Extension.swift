//
//  UIButton+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/26.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
import UIKit

///防止button暴力点击
extension UIControl {
    
    class func initialMethod() {
        let originSelector = #selector(sendAction(_:to:for:))
        let customSelector = #selector(userSendAction(_:to:for:))
        guard let systemMethod = class_getInstanceMethod(self, #selector(sendAction(_:to:for:))) else { return  }
        guard let customMethod = class_getInstanceMethod(self, #selector(userSendAction(_:to:for:))) else { return  }
        
        let didAddMethod = class_addMethod(UIControl.self, originSelector, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))
        if didAddMethod {
            class_replaceMethod(UIControl.self, customSelector, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod))
        } else {
            method_exchangeImplementations(systemMethod, customMethod)
        }
    }
    
    @objc private func  userSendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        self.userSendAction(action, to: target, for: event)
        
        print("\(action)\(NSStringFromClass(object_getClass(target)!))")
    }
}
