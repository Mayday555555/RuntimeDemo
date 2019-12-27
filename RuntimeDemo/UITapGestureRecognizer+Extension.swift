//
//  UITapGestureRecognizer+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/27.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
import UIKit
struct RunTimeTapGestureKey {
    static let timeInterval = UnsafeRawPointer.init(bitPattern: "timeInterval".hashValue)
    static let action = UnsafeRawPointer.init(bitPattern: "action".hashValue)
}
extension UITapGestureRecognizer {
//    var timeInterval: CGFloat? {
//        set {
//            objc_setAssociatedObject(self, RunTimeTapGestureKey.timeInterval!, newValue, .OBJC_ASSOCIATION_COPY)
//        }
//
//        get {
//            return objc_getAssociatedObject(self, RunTimeTapGestureKey.timeInterval!) as? CGFloat
//        }
//    }
//
//    convenience init(target: Any?, action: Selector?, timeInterval: CGFloat) {
//        self.init(target: target, action: action)
//        self.timeInterval = timeInterval
//        self.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        self.isEnabled = false
//        let time: TimeInterval = TimeInterval(self.timeInterval ?? 0)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//            self.isEnabled = true
//        }
//        return true
//    }

        var action: Selector? {
            set {
                objc_setAssociatedObject(self, RunTimeTapGestureKey.action!, newValue, .OBJC_ASSOCIATION_COPY)
            }

            get {
                return objc_getAssociatedObject(self, RunTimeTapGestureKey.action!) as? Selector
            }
        }

    class func initialMethod() {
//        let originSelector = #selector(setter: self.delegate)
//        let swizzleSelector = #selector(self.nsh_setDelegate(delegate:))
//        guard let originMethod = class_getInstanceMethod(UITapGestureRecognizer.self, originSelector) else { return  }
//        guard let swizzleMethod = class_getInstanceMethod(UITapGestureRecognizer.self, swizzleSelector) else { return  }
//
//        let didAddMethod = class_addMethod(UITapGestureRecognizer.self, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
//        if didAddMethod {
//            class_replaceMethod(UITapGestureRecognizer.self, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
//        } else {
//            method_exchangeImplementations(originMethod, swizzleMethod)
//        }

        let initoriginSelector = #selector(self.init(target:action:))
        let initswizzleSelector = #selector(self.nsh_init(target:action:))
        guard let initoriginMethod = class_getInstanceMethod(UITapGestureRecognizer.self, initoriginSelector) else { return  }
        guard let initswizzleMethod = class_getInstanceMethod(UITapGestureRecognizer.self, initswizzleSelector) else { return  }

        let initdidAddMethod = class_addMethod(UITapGestureRecognizer.self, initoriginSelector, method_getImplementation(initswizzleMethod), method_getTypeEncoding(initswizzleMethod))
        if initdidAddMethod {
            class_replaceMethod(UITapGestureRecognizer.self, initswizzleSelector, method_getImplementation(initoriginMethod), method_getTypeEncoding(initoriginMethod))
        } else {
            method_exchangeImplementations(initoriginMethod, initswizzleMethod)
        }

//        let targetoriginSelector = #selector(self.addTarget(_:action:))
//        let targetswizzleSelector = #selector(self.nsh_init(target:action:))
//        guard let targetoriginMethod = class_getInstanceMethod(UITapGestureRecognizer.self, targetoriginSelector) else { return  }
//        guard let targetswizzleMethod = class_getInstanceMethod(UITapGestureRecognizer.self, targetswizzleSelector) else { return  }
//
//        let targetdidAddMethod = class_addMethod(UITapGestureRecognizer.self, targetoriginSelector, method_getImplementation(targetswizzleMethod), method_getTypeEncoding(targetswizzleMethod))
//        if targetdidAddMethod {
//            class_replaceMethod(UITapGestureRecognizer.self, targetswizzleSelector, method_getImplementation(targetoriginMethod), method_getTypeEncoding(targetoriginMethod))
//        } else {
//            method_exchangeImplementations(targetoriginMethod, targetswizzleMethod)
//        }

    }

    @objc func nsh_addTarget(_ target: Any, action: Selector) {
        self.action = action
        self.nsh_addTarget(target, action: action)
    }

    @objc func nsh_init(target: Any?, action: Selector?){
        self.action = action
        self.nsh_init(target: target, action: action)
    }

    @objc func nsh_setDelegate(delegate: UIGestureRecognizerDelegate?) {
        self.nsh_setDelegate(delegate: delegate)

        guard let nDelegate = delegate else {
            return
        }

        let originSelector = #selector(nDelegate.gestureRecognizerShouldBegin(_:))
        let swizzleSelector = #selector(UITapGestureRecognizer.nsh_gestureRecognizerShouldBegin(_:))
        guard let originMethod = class_getInstanceMethod(type(of: nDelegate), originSelector) else { return  }
        guard let swizzleMethod = class_getInstanceMethod(UITapGestureRecognizer.self, swizzleSelector) else { return  }

        let didAddMethod = class_addMethod(type(of: nDelegate), swizzleSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            guard let didoriginMethod = class_getInstanceMethod(type(of: nDelegate), originSelector) else { return  }
            guard let didswizzleMethod = class_getInstanceMethod(type(of: nDelegate), NSSelectorFromString("nsh_gestureRecognizerShouldBegin:")) else { return  }
            method_exchangeImplementations(didoriginMethod, didswizzleMethod)
        }
    }

    @objc func nsh_gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(gestureRecognizer)
        print(gestureRecognizer)

        var count: UInt32 = 0
        let proList = class_copyPropertyList(object_getClass(gestureRecognizer), &count)
        var arr = [String]()
        for i in 0..<count {
            let property = property_getName(proList![Int(i)])
            print("属性：\(String(cString: property))")
            arr.append(String(cString: property))
        }
        print(NSStringFromClass(object_getClass(gestureRecognizer.delegate)!))

        if self.action != nil {
            print(NSStringFromSelector(self.action!))
        }
        self.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.isEnabled = true
        }
        
        return self.nsh_gestureRecognizerShouldBegin(gestureRecognizer)

    }
}
