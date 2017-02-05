//
//  FLHttpSessionManager.swift
//  swiftLearning
//
//  Created by clarence on 17/2/5.
//  Copyright © 2017年 gitKong. All rights reserved.
//

import UIKit

class FLHttpSessionManager: NSObject {
    
    var session:URLSession?
    var baseUrl:URL?
    
    override init (){
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }
    
    init(baseUrl : URL,configuration:URLSessionConfiguration){
        
        super.init()
        
        var url = baseUrl
        // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
        if !url.path.isEmpty && !url.absoluteString.hasSuffix("/") {
            url = url.appendingPathComponent("")
        }
        self.baseUrl = url
        
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    
    
    func fl_dataTask(url:URL,httpMethod:String,parmas:Dictionary<String, Any>,completionHandler:@escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask{
        
        var tempUrl:URL?
        // 拼接基路径
        if url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") {
            tempUrl = url
        }
        else{
            
            tempUrl = self.baseUrl?.appendingPathComponent(url.absoluteString)
            // 这个方法不能拼接baseurl
            // URL(string: url.absoluteString, relativeTo: self.baseUrl)
        }
        
        // 判断url是否有效
        assert(tempUrl!.absoluteString != "", "url 不能为空")
        
        
        let bodyStr : String = self.fl_httpBodyString(parmas: parmas)
        
        if httpMethod == "POST" {
            
        }
        else if httpMethod == "GET"{
            // 这个方法会将？转义
            // tempUrl?.appendingPathComponent(<#T##pathComponent: String##String#>)
            
            tempUrl = URL(string: (tempUrl?.absoluteString.appending("?"+"\(bodyStr)"))!)
        }
        
        print("------------url ？ = \(tempUrl!)")
        var request = URLRequest(url: tempUrl!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10.0)
        
        // 请求方法
        request.httpMethod = httpMethod
        
        if httpMethod == "POST" {
            // 请求头
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            // 请求体
            request.httpBody = bodyStr.data(using: String.Encoding.utf8)
        }
        else if httpMethod == "GET"{
            
        }
        
        return self.fl_dataTask(request: request, completionHandler: completionHandler)
    }
    
    
    func fl_dataTask(request:URLRequest,completionHandler:@escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask{
        
        let dataTask = self.session!.dataTask(with: request) { (data, response, error) in
            // 回到主线程
            DispatchQueue.main.async {
                completionHandler(data,response,error)
            }
        }
        dataTask.resume()
        
        return dataTask
    }
    
    
    func fl_dataTask(with url:URL ,completionHandler:@escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask{
        
        let dataTask = self.session!.dataTask(with: url) { (data, response, error) in
            print("\(response)")
            }
        
        dataTask.resume()
        
        return dataTask
    }
    
    private func fl_httpBodyString(parmas:Dictionary<String, Any>)->String{
        let tempArr = NSMutableArray()
        for key in parmas.keys {
            // 解包去掉optional
            let value = parmas[key]!
            print("----------value = \(value)")
            tempArr.add("\(key)"+"="+"\(value)")
        }
        return tempArr.componentsJoined(by: "&")
    }
}

extension FLHttpSessionManager:URLSessionTaskDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust){
            // 使用受保护空间的服务器信任创建凭据
            let credential:URLCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            // 通过 completionHandler 告诉服务器信任证书
            completionHandler(URLSession.AuthChallengeDisposition.useCredential,credential);
        }
    }
}
