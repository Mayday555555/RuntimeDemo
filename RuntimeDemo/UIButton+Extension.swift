//
//  UIButton+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/31.
//  Copyright © 2019 xuanze. All rights reserved.
//

struct ButtonKey {
    static let ButtonTopEdgeKey = UnsafeRawPointer(bitPattern: "ButtonTopEdgeKey".hashValue)
    static let  ButtonBottomEdgeKey = UnsafeRawPointer(bitPattern: "ButtonTopEdgeKey".hashValue)
    static let  ButtonLeftEdgeKey = UnsafeRawPointer(bitPattern: "ButtonTopEdgeKey".hashValue)
    static let  ButtonRightEdgeKey = UnsafeRawPointer(bitPattern: "ButtonTopEdgeKey".hashValue)
}

import Foundation
import UIKit
//扩大按钮的点击范围
extension UIButton {
    var topEdge: CGFloat? {
        set {
            objc_setAssociatedObject(self, ButtonKey.ButtonTopEdgeKey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, ButtonKey.ButtonTopEdgeKey!) as? CGFloat
        }
    }
    
    var bottomEdge: CGFloat? {
        set {
            objc_setAssociatedObject(self, ButtonKey.ButtonBottomEdgeKey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, ButtonKey.ButtonBottomEdgeKey!) as? CGFloat
        }
    }
    
    var leftEdge: CGFloat? {
        set {
            objc_setAssociatedObject(self, ButtonKey.ButtonLeftEdgeKey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, ButtonKey.ButtonLeftEdgeKey!) as? CGFloat
        }
    }
    
    var rightEdge: CGFloat? {
        set {
            objc_setAssociatedObject(self, ButtonKey.ButtonRightEdgeKey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, ButtonKey.ButtonRightEdgeKey!) as? CGFloat
        }
    }
    
    func setEnlargeEdge(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.topEdge = top
        self.bottomEdge = bottom
        self.leftEdge = left
        self.rightEdge = right
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let top = self.topEdge ?? 0
        let bottom = self.bottomEdge ?? 0
        let right = self.rightEdge ?? 0
        let left = self.leftEdge ?? 0
        
        let rect = CGRect(x: self.bounds.origin.x - left, y: self.bounds.origin.y - top, width: self.bounds.size.width + left + right, height: self.bounds.size.height + top + bottom)
        if rect.contains(point) {
            return self
        } else {
            return nil
        }
    }
}
