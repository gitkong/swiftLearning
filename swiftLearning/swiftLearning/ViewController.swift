//
//  ViewController.swift
//  swiftLearning
//
//  Created by clarence on 17/2/4.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

// 结构体
struct Color {
    static var red,green,blue:Double?
//    init(red:Double, green:Double,blue:Double) {
//        self.red = red;
//        self.green = green
//        self.blue = blue
//    }
}



struct Result {
    var success,failure:(Any)->()?
    init() {
        success = {
            (data)->()
            in
            
        }
        failure = {
            (error)->()
            in
            
        }
    }
}

typealias Complete = (String)->()
enum Response {
    case success(Complete)
    case failure(String)
}

class ViewController: UIViewController {
    
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let color = Color(red: 1.0, green: 1.0, blue: 1.0);
//        
//        print("\(color.blue)")
        
        
        
        result.success = {
            (data)->()
            in
            print("\(data)")
        }
        
        result.failure = {
            (error)->()
            in
            print("\(error)")
        }
        
        
        
        
        // 数组遍历
        let arr:Array = ["one","two","third","four","five"]
        for obj in arr {
            print("\(obj)")
        }
        
        for (index,obj) in arr.enumerated() {
            print("\(index)----\(obj)")
        }
        
        
        // 闭包
        
        let block:(Response)->() = {
            (response) -> ()
            in
            switch response {
            case .success(let complete):
                complete("hello world")
                break
            default:
                print("clarence")
            }
            
        }
        // 枚举和闭包组合玩法
        block(Response.success({ (message) in
            print("\(message)")
        }))
        
        
        /*
         swift 中，如果要使用某一个类，是不用import头文件的，因为swift中新增了一个OC钟没有的概念 “命名空间”，只要在同一个命名空间中的资源都是共享的，默认情况下，项目名称就是命名空间
         */
        
        /*
         正因为这个，所以swift项目要使用第三方框架的时候，建议使用cocoaPods来集成，这样就跟自己的项目的命名空间不一样，避免类名冲突
         */
        
        // 构造方法
        let model = Model(name: "clarence")
        print("\(model.name)")
        
//        NSURLConnection
//        URLSession
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 闭包
        test { (num) -> (String) in
            return "hello world" + String(num)
        }
        
        
        
        result.success("hello world")
        result.failure("error lalalala")
    }
    
    func test(finish : (Int)->(String)) {
        print("gitkong" + finish(100))
        
    }

    // 懒加载
    lazy var imageList:[String] = {
        
        return []
    }()
    
    // getter & setter
    
    // 一般不需要这样写，因为还要再定义一个属性
    
    /*
     如果只是重写了get方法，那么这个属性就是计算型属性，而且不需要加 ？ ，也就是对应OC中的只读属性，计算型属性不占用内存空间
     */
    
    var _name:String?
    var name:String?{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
    // setter建议这样写
    var gender:String?{
        // 会在设置完值之后调用
        // swift 中使用didSet来替代OC中重写setter方法
        didSet{
           print("\(gender)")
        }
    }
    
    
    

}

