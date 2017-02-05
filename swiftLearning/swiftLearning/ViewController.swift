//
//  ViewController.swift
//  swiftLearning
//
//  Created by clarence on 17/2/4.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // GET
//        let url:URL = URL(string: "http://60.205.59.95/v1/dish/info")!
        print(self)
        // POST
        let url:URL = URL(string: "/Ajax/ckUserFocus")!
        let baseUrl:URL = URL(string: "http://liveapi.vzan.com")!
        let manager = FLHttpSessionManager(baseUrl: baseUrl, configuration: URLSessionConfiguration.default)
        
        let params:[String:Any] = [
            "deviceType" : 2,
            "sign" : "D850556EE632E270ACEC2714BA07C69EFED6406E1FB8E8264EBCECD8958A9B289C0CAE35AA5C2BAE",
            "timestamp" : 1486286686332,
            "uid" : "oW2wBwStFjhB_6oAWRDC2ocW2sSs",
            "versionCode" : "2.0.6",
            "zbid" : 162120
        ]
        _ = manager.fl_dataTask(url: url, httpMethod: "POST", parmas: params, completionHandler: { (data, response, error) in
            print("\(response)"+"\(Thread.current)")
            if (error != nil){
                print("\(error)")
            }
            do{
                guard data != nil else {
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
            }
            catch{
                print("error")
            }
        })
        
        
        let block = {
            () -> ()
            in
            print("clarence")
        }
        block()
        
        
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

