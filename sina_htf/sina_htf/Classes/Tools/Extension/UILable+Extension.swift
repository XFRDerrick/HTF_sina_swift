//
//  UILable+Extension.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/17.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

//最顶级的一个类  没有继承自任何一个类

extension UILabel {
    
    //convenience  表示便利构造函数
    convenience init (title:String, color:UIColor ,fontSize:CGFloat){
    
        self.init()
        //意味着可以获得一个实例化的对象
        //Lable的属性设置
        text = title
        textColor = color
        textAlignment = .Center
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        sizeToFit()
    }

}