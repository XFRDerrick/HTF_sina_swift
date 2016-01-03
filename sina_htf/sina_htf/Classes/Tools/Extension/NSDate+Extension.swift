//
//  NSDate+Extension.swift
//  sina_htf
//
//  Created by 赫腾飞 on 16/1/3.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import Foundation

extension NSDate {

    //将字符串转换成 日期对象
    class func sinaDate(str:String) ->NSDate? {
         //实例化一个nsdateFormater 对象
        
        let df = NSDateFormatter()
        //指定 日期格式对象的具体格式
        df.dateFormat = "EEE MM dd HH:mm:ss zzz yyyy"
        //一定设置 本地化信息 在模拟器中可以运行 但是真机中没有办法转换日期对象
        df.locale = NSLocale(localeIdentifier: "en")
        
        let date = df.dateFromString(str)
        
        //在转换为字符串对象的时候  会自动加上时区
        
        return date
        
    }
    
    //将日期对象 转换成字符串
    func fullText() -> String {
        
        let df = NSDateFormatter()
        
        df.dateFormat = "yyyy-MMM-dd HH:mm"
        
        let str = df.stringFromDate(self)
        return str
    }
    

}