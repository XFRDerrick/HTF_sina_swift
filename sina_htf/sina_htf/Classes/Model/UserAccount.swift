//
//  UserAccount.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/14.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit
//自定义对象的归档操作
//对用户数据的对象保存

class UserAccount: NSObject {
    
    //MARK: 定义属性
    //用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    //access_token的生命周期，单位是秒数。
//    var expires_in: String?
     var expires_in: NSTimeInterval = 0
    
//    var remind_in
    //当前授权用户的UID。
    var uid: String?
    
    
    //友好显示名称
    var name: String?
    //用户头像地址（大图），180×180像素
    var avatar_large: String?
    //MARK: 重写description使用kvc给对象设置初始值
    init(dict: [String: AnyObject]) {
        //对象构造的最后一步
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //MARK: 重写description
    override var description: String{
     
        let keys  = ["access_token","expires_in","uid","name","avatar_large"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
    
    
    
    
}
