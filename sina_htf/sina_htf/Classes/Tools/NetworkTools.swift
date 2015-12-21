//
//  NetworkTools.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/21.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import AFNetworking

class NetworkTools: AFHTTPSessionManager {

    //网络请求的处理层 以后的网络请求都是用此类进行数据的获取
    //声明单例对象
    static let sharedTools: NetworkTools = {
        
        let urlString = "https://api.weibo.com/"
        let url = NSURL(string: urlString)
        let tools = NetworkTools(baseURL: url)
    
        return tools
    }()
    
    
    
}
