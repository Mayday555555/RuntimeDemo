//
//  UITableView+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/27.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    class func initialMethod() {
        let originSelector = #selector(setter: self.delegate)
        let swizzleSelector = #selector(self.nsh_setDelegate(delegate:))
        guard let originMethod = class_getInstanceMethod(UITableView.self, originSelector) else { return  }
        guard let swizzleMethod = class_getInstanceMethod(UITableView.self, swizzleSelector) else { return  }
        let didAddMethod = class_addMethod(UITableView.self, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            class_replaceMethod(UITableView.self, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
        } else {
            method_exchangeImplementations(originMethod, swizzleMethod)
        }
    }
    
    @objc func nsh_setDelegate(delegate: UITableViewDelegate?) {
        self.nsh_setDelegate(delegate: delegate)
        
        guard let nDelegate = delegate else {
            return
        }
        
        let originSelector = #selector(nDelegate.tableView(_:didSelectRowAt:))
        let swizzleSelector = #selector(UITableView.nsh_tableView(_:didSelectRowAt:))
        guard let originMethod = class_getInstanceMethod(type(of: nDelegate), originSelector) else { return  }
        guard let swizzleMethod = class_getInstanceMethod(UITableView.self, swizzleSelector) else { return  }
        let didAddMethod = class_addMethod(type(of: nDelegate), swizzleSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            guard let didoriginMethod = class_getInstanceMethod(type(of: nDelegate), originSelector) else { return  }
            guard let didswizzleMethod = class_getInstanceMethod(type(of: nDelegate), NSSelectorFromString("nsh_tableView:didSelectRowAt:")) else { return  }
            method_exchangeImplementations(didoriginMethod, didswizzleMethod)
        }
    }
    
    @objc func nsh_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        self.nsh_tableView(tableView, didSelectRowAt: indexPath)
        print("\(NSStringFromClass(object_getClass(tableView.delegate)!))")
        let cell = tableView.cellForRow(at: indexPath)
        print("\(NSStringFromClass(object_getClass(cell)!))")
    }
}
