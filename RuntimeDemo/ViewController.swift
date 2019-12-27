//
//  ViewController.swift
//  RuntimeDemo
//
//  Created by xuanze on 2019/7/25.
//  Copyright © 2019 xuanze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{

    let vcName = "haha"
    var count: UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBtn()
        
        let swiftClass = TestSwiftRunTime()
//        let arr = swiftClass.getProperties()
        
        let proList = class_copyPropertyList(object_getClass(swiftClass), &count)
        for i in 0..<count {
            let property = property_getName(proList![Int(i)])
            print("属性：\(String(cString: property))")
        }
        
        let dog = Dog()
        dog.str = "haha"
        print(dog.str)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapgesTap(tap:)))
        tapGes.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGes)
        
        let nameSpage = Bundle.main.infoDictionary!["CFBundleExecutable"] 
    }
    
    func  addBtn() {
        let btncom = UIButton(type: .custom)
        btncom.setTitle("OC", for: .normal)
        btncom.setTitleColor(UIColor.black, for: .normal)
        btncom.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btncom.addTarget(self, action: #selector(self.toOCVC(btn:)), for: .touchUpInside)
        btncom.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        btncom.setEnlargeEdge(top: 20, bottom: 20, left: 20, right: 20)
        self.view.addSubview(btncom)
    }

    @objc func toOCVC(btn: UIButton) {
//        let ocvc = OCViewController()
//        self.present(ocvc, animated: true, completion: nil)
        
        print("buttonTap")
    }
    
    @objc func tapgesTap(tap: UITapGestureRecognizer) {
        print("tapgesTap")
    }

    @IBAction func bBtnTap(_ sender: Any) {
        print("bBtnTap")
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
}

