//
//  StatusListViewModel.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/21.
//  Copyright © 2015年 hetefe. All rights reserved.
//

//封装网络请求

import UIKit

import SVProgressHUD
class StatusListViewModel: NSObject {

    
    class func loadHomePageData(since_id: Int64 ,max_id: Int64 , finished: (statues: [Status]?) -> () ) {
      
        //get请求
        let urlString = "2/statuses/home_timeline.json"// "https://api.weibo.com/2/statuses/home_timeline.json"
        
        guard let token = UserAccountViewModel().token else{
            
            print("token为nil")
            SVProgressHUD.showInfoWithStatus("请重新登录")
            return
        }
        
        var parameters = ["access_token" : token]
        
        if since_id > 0 {
            parameters["since_id"] = "\(since_id)"
        }
        if max_id > 0 {
        
            parameters["max_id"] = "\(max_id)"
        }
        
        
        NetworkTools.sharedTools.requestJSONDict(.GET, urlString: urlString, parameters: parameters) { (dict, error) -> () in
            if error != nil {
                //执行失败的回调
                finished(statues: nil)
                SVProgressHUD.showInfoWithStatus("网络出错请稍后再试")
                return
            }
            //请求成功
            if let array = dict!["statuses"] as? [[String : AnyObject]]{
                
                var list = [Status]()
                for item in array {
                    //遍历获取模型 存入模型
                    let s = Status(dict: item)
                    list.append(s)
                    
                }
                
                //执行成功的回调
                finished(statues: list)

            }
            
            
        }
    }
    
}
