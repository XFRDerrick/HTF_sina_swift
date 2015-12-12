//
//  MainViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/12.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加子视图控制器
        addChildViewControllers()
        
    }

    private func addChildViewControllers() {
    
        addChildViewController("首页", imageName: "tabbar_home", vc: HomeTableViewController())
        addChildViewController("消息", imageName: "tabbar_message_center", vc: MessageTableViewController())
        addChildViewController("发现", imageName: "tabbar_discover", vc: DiscoverTableViewController())
        addChildViewController("我", imageName: "tabbar_profile", vc: ProfileTableViewController())
    }
    
    private func addChildViewController(title:String , imageName:String,vc:UIViewController) {
        
        view.tintColor = UIColor.orangeColor()
        //添加Tabbaritem Controller
        let nav = UINavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        
        
        self.addChildViewController(nav)
        
    }
    
    
}
