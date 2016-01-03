//
//  String+Regex.swift
//  微博来源
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 itcast. All rights reserved.
//

import Foundation


extension String {
    
    //元祖类型
    func linkAndText() -> (text: String, url: String){
        //匹配方案 会将完整匹配对象 获取到  同时 还会获取 ()内的对象
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        //将字符串中的 http://app.weibo.com/t/feed/3jskmg  iPhone 6s
        //实例化正则表达式对象
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        //通过正则表达式对象 调用 其核心方法
        //匹配第一个 pattern 找到第一个匹配对象就返回
        let result = regex.firstMatchInString(self, options: [], range: NSRange(location: 0, length: characters.count))
        
        //有多少个范围  数量 numberOfRanges = ()数量 + 1
        
        var subStr1 = ""
        var subStr2 = ""
        
        let range1 = result?.rangeAtIndex(1)
        let range2 = result?.rangeAtIndex(2)
        if let r1 = range1 {
            subStr1 = (self as NSString).substringWithRange(r1)
        }
        if let r2 = range2 {
            subStr2 = (self as NSString).substringWithRange(r2)
        }
        return (subStr2,subStr1)
    }
}