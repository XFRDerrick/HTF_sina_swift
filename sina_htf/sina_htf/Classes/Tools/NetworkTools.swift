//
//  NetworkTools.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/21.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import AFNetworking

let dataErrorDomain = "com.baidu.data.error"

class NetworkTools: AFHTTPSessionManager {

    //网络请求的处理层 以后的网络请求都是用此类进行数据的获取
    //声明单例对象
    static let sharedTools: NetworkTools = {
        
        //设置base  URL
        let urlString = "https://api.weibo.com/"
        let url = NSURL(string: urlString)
        let tools = NetworkTools(baseURL: url)
    
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    
    //网络请求的核心方法封装
    
    func requestJSONDict(urlString:String, parameters:[String: String]?, finished: (dict: [String: AnyObject]?, error: NSError?) ->() ) {
    
        //发送POST请求 
        POST(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (_, result) -> Void in
                print(result)
                guard let dict = result as? [String: AnyObject] else {
                
                    //不能够转换为字典
                    //执行失败的回调
                    //domain 反转的域名  com.baidu.error
                    //code ： 错误状态码 自己定义的错误信息  一般使用负数
            
                    let myError = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey:"数据不合法"])
                    
                    print(myError)
                    finished(dict: nil, error: myError)
                    return
                }
                //执行成功的回调
                finished(dict: dict, error: nil)
                
            }) { (_, error) -> Void in
                //请求失败的回调  请求失败的回调
                finished(dict: nil, error: error)
                print(error)
        }
        
        GET(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (_, result) -> Void in
                print(result)
                
            }) { (_, error) -> Void in
                print(error)
        }
        
        
        
    }
    
    
    
}
