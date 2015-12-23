//
//  MainViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/12.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    //必选的属性
//MARK:- 创建自定义的Tabbar对象
    let mainTarBar = MainTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tabBar 是只读属性的 不能直接进行设置 可以使用kvc在运行的时候 间接赋值
        
        setValue(mainTarBar, forKey: "tabBar")
        
        mainTarBar.composeBtn.addTarget(self, action: "clickComposeBtn", forControlEvents: .TouchUpInside)
        
        //添加子视图控制器
        addChildViewControllers()
    
    }

    //private func 是swift中函数的特殊声明形式 希望swift方法选择器 + 访问控制关键字能够兼容
    //需要使用 @objc
    //@objc private 要保证监听方法的安全性 并且可以影响点击事件的特殊写法
    
//MARK:- 点击Tabbar上得加号按钮的点击响应事件
    @objc private func clickComposeBtn(){
    
//        print(__FUNCTION__)
        let compose = ComposeViewController()
        
        let nav = UINavigationController(rootViewController: compose)
        
        presentViewController(nav, animated: true, completion: nil)
        
        
    }
//MARK:- 添加Tabbar对应的控制器
    private func addChildViewControllers() {
        //调用pch 的tool工具设置颜色
        tabBar.tintColor = themeColor
        addChildViewController("首页", imageName: "tabbar_home", vc: HomeTableViewController())
        addChildViewController("消息", imageName: "tabbar_message_center", vc: MessageTableViewController())
        addChildViewController("发现", imageName: "tabbar_discover", vc: DiscoverTableViewController())
        addChildViewController("我", imageName: "tabbar_profile", vc: ProfileTableViewController())
    }
//MARK:- 添加Tabbar对应的控制器的方法
    private func addChildViewController(title:String , imageName:String,vc:UIViewController) {
        //添加Tabbaritem Controller
        let nav = UINavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        self.addChildViewController(nav)
        
    }
    
    
}
