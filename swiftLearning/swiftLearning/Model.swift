//
//  Model.swift
//  swiftLearning
//
//  Created by clarence on 17/2/4.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class Model: NSObject {
    // 如果定义属性没有初始化，那么后面必须加上一个？
    // swift 要求，属性必须有初始值
    // 只要在构造方法中对属性进行了初始化，那么就不用写？
    var name:String?
    
    /*
     如果定义一个 “对象类型” 那么后面可以写 ？
     如果定义一个 “基本数据类型属性” 那么建议直接赋值为 0
     */
    var age:Int = 0
    
    override init(){
        self.name = "gitkong"
        self.age = 12
    }
    
    // 重载
    init(name:String) {
        self.name = name
        self.age = 12
    }
    
    init(dict:[String:NSObject]) {
        
        super.init()
        // 调用方法前，需要先对属性进行分配存储空间，调用super.init()就可以，有个坑就是属性都需要是可选类型的，但是基本数据类型能是可选的；
        
        // 因为如果属性是一个基本数据类型，并且是可选的，那么super.init() 不会给该属性分配存储空间
        test()
    }
    
    func test(){
        
    }
    
    // 创建单例
    static let shareInstance : Model = Model()
}
