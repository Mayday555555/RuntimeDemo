//
//  NSObject+Extension.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/26.
//  Copyright © 2019 xuanze. All rights reserved.
//

import Foundation
extension NSObject {
    func getProperties()->[String] {
        var count: UInt32 = 0
        let proList = class_copyPropertyList(object_getClass(self), &count)
        var arr = [String]()
        for i in 0..<count {
            let property = property_getName(proList![Int(i)])
            print("属性：\(String(cString: property))")
            arr.append(String(cString: property))
        }
        return arr
    }
}
