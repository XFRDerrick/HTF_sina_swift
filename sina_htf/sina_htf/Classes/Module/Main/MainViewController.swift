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
        addChildViewController()
        
    }

    private func addChildViewController() {
        
        
        //添加homeVC
        
        let homeVC = HomeTableViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        homeVC.title = "首页"
        self.addChildViewController(nav)
        
        //添加messageVC
        let messageVC = MessageTableViewController()
        let navMessage = UINavigationController(rootViewController: messageVC)
        messageVC.title = "消息"
        self.addChildViewController(navMessage)
        
        //添加discover
        let discoverVC = DiscoverTableViewController()
        let navDiscover = UINavigationController(rootViewController: discoverVC)
        discoverVC.title = "发现"
        self.addChildViewController(navDiscover)
        
        //添加profile
        let profileVC = ProfileTableViewController()
        let navProfile = UINavigationController(rootViewController: profileVC)
        profileVC.title = "我"
        self.addChildViewController(navProfile)
        
    }
    
}
