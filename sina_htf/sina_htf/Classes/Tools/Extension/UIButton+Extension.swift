//
//  UIButton+Extension.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/17.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit


extension UIButton {
    
    //convenience  表示便利构造函数
    convenience init (imageNameN:String, imageNameH:String,color:UIColor ,title:String){
        
        self.init()
        //意味着可以获得一个实例化的对象
        //Lable的属性设置
        setBackgroundImage(UIImage(named: imageNameH), forState:.Highlighted )
        setBackgroundImage(UIImage(named: imageNameN), forState: .Normal)
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        
        //设置大小
        sizeToFit()
    }
    
}