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
    convenience init (backImageNameN:String, backImageNameH:String?,color:UIColor ,title:String,fontOfSize:CGFloat){
        
        self.init()
        //意味着可以获得一个实例化的对象
        //Lable的属性设置
        
        //当没有此项时进行判断 可为空
        if let _ = backImageNameH {
            setBackgroundImage(UIImage(named: backImageNameH!), forState:.Highlighted )
        }
        
        setBackgroundImage(UIImage(named: backImageNameN), forState: .Normal)
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontOfSize)
        //设置大小
        sizeToFit()
    }
    
    //convenience  表示便利构造函数
    convenience init ( imageNameN:String, imageNameH:String , backImageNameN:String, backImageNameH:String?){
        
        self.init()
        setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    
    
    
    
}