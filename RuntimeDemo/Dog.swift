//
//  Dog.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/26.
//  Copyright © 2019 xuanze. All rights reserved.
//

import UIKit

class Dog: NSObject {
    var name = ""
    var age = ""
}
var dogKey = "dogKey"
extension Dog {
    var str: String? {
        set {
            objc_setAssociatedObject(self, dogKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, dogKey) as? String
        }
    }
}
