//
//  UIApplication+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/29.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func hook() {
        guard let originMethod = class_getInstanceMethod(UIApplication.self, #selector(sendAction(_:to:from:for:))) else { return  }
        guard let swizzleMethod = class_getInstanceMethod(UIApplication.self, #selector(hook_sendAction(_:to:from:for:))) else { return  }
        
        method_exchangeImplementations(originMethod, swizzleMethod)
    }
    
    @objc func hook_sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        let info = "\(NSStringFromClass(object_getClass(target)!)) - \(NSStringFromClass(object_getClass(sender)!)) - \(NSStringFromSelector(action))"
        print(info)
        
        return self.hook_sendAction(action, to: target, from: sender, for: event)
    }
}
