//
//  Status.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

 /**


返回值字段	字段类型	字段说明
created_at	string	微博创建时间
id	int64	微博ID
text	string	微博信息内容
source	string	微博来源

favorited	boolean	是否已收藏，true：是，false：否
truncated	boolean	是否被截断，true：是，false：否
in_reply_to_status_id	string	（暂未支持）回复ID
in_reply_to_user_id	string	（暂未支持）回复人UID
in_reply_to_screen_name	string	（暂未支持）回复人昵称
thumbnail_pic	string	缩略图片地址，没有时不返回此字段
bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
original_pic	string	原始图片地址，没有时不返回此字段
geo	object	地理信息字段 详细
user	object	微博作者的用户信息字段 详细
retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
reposts_count	int	转发数
comments_count	int	评论数
attitudes_count	int	表态数
mlevel	int	暂未支持
visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
ad	object array	微博流内的推广微博ID
*/

import UIKit

class Status: NSObject {
    
    //微博创建时间
    var created_at: String?
    
    //int64	微博ID 在iPhone 5c一下的设备上 会导致整形数据被截掉
    var id: Int = 0
    
    //text	string	微博信息内容
    var text: String?
    
    //source	string	微博来源
    var source: String?
    
    //用户模型
    var user: User?
    
    //配图数据
    var pic_urls: [[String: String]]?{
        
        didSet{
            guard let array = pic_urls else {
                return
            }
            //遍历数组
            //将数组实例化
            imageURLs = [NSURL]()
            for item in array{
                //一定能够显示
                var urlString = item["thumbnail_pic"]!
                
                urlString = urlString.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
                let url = NSURL(string: urlString)
                //添加URL
                imageURLs!.append(url!)
            }
        
        }
    
    }
    //将获取的数组数据， 转换成URL对象
    var imageURLs: [NSURL]?
    
    
    //构造方法 kvc设置
    init(dict: [String : AnyObject]) {
    
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
  
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
        //字典转模型
            if let dict = value as? [String : AnyObject]{
                 user = User(dict: dict)
//                print("-----------------------user-----------------------")
//                print(user)
            }
            //需要加return 否则白做了
            return
        }
        super.setValue(value, forKey: key)
    }
    
    //过滤未使用字段
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    override var description: String {
    
        let keys = ["created_at", "id", "text", "source","user"]
        return dictionaryWithValuesForKeys(keys).description
    
    }
    
    
}
