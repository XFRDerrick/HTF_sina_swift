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
import SDWebImage

class StatusListViewModel: NSObject {

    
    class func loadHomePageData(since_id: Int64 ,max_id: Int64,finished: (statues: [Status]?) -> () ) {
      
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
        
            parameters["max_id"] = "\(max_id - 1)"
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
                //下载所有的单张图片 下载完之后进行回调
                cacheStatusImage(list, finished: finished)
                
                //执行成功的回调
                finished(statues: list)

            }
 
        }
    }
    
    class func cacheStatusImage(list: [Status], finished: (statues: [Status]?) -> () ) {
        //下载所有的单张图片
        //遍历数组
        if list.count == 0 {
            //一定要执行回调
            finished(statues: list)
            return
        }
        //创建群组对象 buffer 池子 将所有需要箭筒的异步任务放入到任务池中
        let group = dispatch_group_create()
        
        
        for s in list {
           
            if let urls = s.pictureURLs where  urls.count != 1 {
            
                continue
            }
            //下载单张图片  等待所有的单张图片下载完毕再进行回调
            //如何监听所有的异步任务完成 群组异步
            //在下载之前将异步任务添加到任务池
            //入组
            dispatch_group_enter(group)
            SDWebImageManager.sharedManager().downloadImageWithURL(s.pictureURLs?.last, options: [], progress: nil, completed: { (_, _, _, _, _) -> Void in
//                print("下载单张图片成功")
                
                //任务完成之后 必须出租  入组和出租是一一对应的有如有出
                dispatch_group_leave(group)
            })
            
        }
        //群组任务监听  对应的任务数量为零的时候 会触发监听方法
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            //完成回调 
            finished(statues: list)
        }
    }
    
}
