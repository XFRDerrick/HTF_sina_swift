//
//  MainTabBar.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/12.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit


class MainTabBar: UITabBar {
    
    //UIView的默认构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //添加addBtn
        addSubview(composeBtn)
        
    }
    //如果通过XIB进行创建 会调用这个方法
    //如果实现了 init（frame）意味着当前这个类么欧人支持手吗 创建不会调用此方法
    
    required init?(coder aDecoder: NSCoder) {
        //默认实现报错
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    //根据UI需求界面设置frame
    
    //在此方法中设置所有的子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.bounds.width / 5
        let h = self.bounds.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        
        //遍历所有的子视图
        
        var index : CGFloat = 0
        for subView in subviews {
            
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                
                subView.frame = CGRectOffset(rect, index * w, 0)
                //三目运算符
                
                index += (index == 1) ? 2 : 1
            }
            
        }
        composeBtn.frame = CGRectOffset(rect, 2 * w, 0)
        
        //        composeBtn.frame = CGRectOffset(rect, 2 * w, -20)
        //将btn上移 并将显示按钮置前
        //        bringSubviewToFront(composeBtn)
    }
    
    //懒加载加号按钮
    //MARK:- 添加加号按钮的懒加载方法
    lazy var composeBtn : UIButton = UIButton(imageNameN: "tabbar_compose_icon_add", imageNameH: "tabbar_compose_icon_add_highlighted", backImageNameN: "tabbar_compose_button", backImageNameH: "tabbar_compose_button_highlighted")
    
}
