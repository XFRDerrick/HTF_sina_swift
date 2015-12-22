//
//  UserAccountViewModel.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/14.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import AFNetworking


//MARK:- 封装网络请求
class UserAccountViewModel: NSObject {
    
    //定义用户模型对象属性
    var userAccount : UserAccount?
    
    override init() {
        userAccount = UserAccount.loadAccount()
        super.init()
    }
    //MARK:- 计算性属性 用户是否登录
    var userLogin :Bool {
        return userAccount?.access_token != nil
    }
    
    //用户头像的url
    var headURL: NSURL? {
        let url = NSURL(string: userAccount?.avatar_large ?? "")
        return url
    }
    
    var token: String? {
        return userAccount?.access_token
    }
    
    
    //MARK: - 加载用户token （请求标识） 添加回调闭包
    func loadAccssToken(code:String ,finish:(isSuccess: Bool) ->()){
        
        let urlString = "oauth2/access_token"//"https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":client_id, "client_secret":client_secret, "grant_type": "authorization_code", "code":code, "redirect_uri":redirect_uri]
       
        NetworkTools.sharedTools.requestJSONDict(.POST,urlString:urlString, parameters: parameters) { (dict, error) -> () in
            print(dict)
            if error != nil {
                //请求失败
                //执行失败的回调
                finish(isSuccess: false)
                return
                
            }
            //字典转模型
            let userAccount = UserAccount(dict: dict!)
            
            self.loadUserInfo(userAccount, finish: finish)
            print("----------------------------------------------------")
        }
        
    }
    //MARK: - 获取用户信息
    private func loadUserInfo(account: UserAccount ,finish:(isSuccess: Bool) ->()){
        
        let urlString = "2/users/show.json"//"https://api.weibo.com/2/users/show.json"
        
        //制定 中不能存放nil
        if let token = account.access_token,userId = account.uid{
            
            let parameters = ["access_token": token,"uid":userId]
            
            NetworkTools.sharedTools.requestJSONDict(.GET, urlString: urlString, parameters: parameters, finished: { (dict, error) -> () in
                
                if error != nil {
                
                    //失败的回调
                    finish(isSuccess: false)
                    return
                }
                
                let avatar_large = dict!["avatar_large"] as! String
                let name = dict!["name"] as! String
                //给account 对象的属性做赋值操作
                account.name = name
                account.avatar_large = avatar_large
                
                //获取用户的完整自定义对象
                //存储自定义对象
                account.saveAccount()
                //执行成功共
                finish(isSuccess: true)
                
                
            })
        }
        
    }
    

    
    
}
