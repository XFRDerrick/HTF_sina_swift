//
//  User.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //id	int64	微博ID
    var id :Int64 = 0
    
    //友好显示名称
    var name: String?
    
    //Y用户头像地址
    var profile_image_url: String?
    
    //用户头像的URL
    var headURL: NSURL? {
        
        get{
            return NSURL(string: profile_image_url ?? "")
        }
    }

    //verified_type	int	已经支持
    var verified_type : Int = -1
    //-1 没有认证  235 企业认证  0 认证用户  220 达人
    var verified_type_image: UIImage? {
        
        switch verified_type {
        case -1 : return nil
        case 0 : return UIImage(named: "avatar_vip")
        case 2,3,5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default : return nil
        }
    }
    //会员等级 0-6
    var mbrank: Int = 0
    //等级图片设置
    var mbrankImage : UIImage? {
        //是否有等级
        if mbrank > 0 && mbrank < 7 {
            
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    init(dict:[String : AnyObject]){
        
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    
    override var description: String {
        
        let keys = ["name", "id", "profile_image_url", "verified_type", "mbrank"]
        return dictionaryWithValuesForKeys(keys).description
        
    }
    

}
