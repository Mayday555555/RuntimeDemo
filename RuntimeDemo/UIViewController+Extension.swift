//
//  UIViewController+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/26.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    class func initialMethod() {
        let originSelector = #selector(viewDidLoad)
        let swizzleSelector = #selector(userViewDidload)
        guard let originalMethod = class_getInstanceMethod(self, originSelector) else { return  }
        guard let swizzledMethod = class_getInstanceMethod(self, swizzleSelector) else { return  }
        let didAddMethod = class_addMethod(self, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(self, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @objc func userViewDidload() {
        self.userViewDidload()
        print("类名\(String(describing: object_getClass(self)))")
    }
}
