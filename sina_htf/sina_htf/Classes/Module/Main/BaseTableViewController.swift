//
//  BaseTableViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit



class BaseTableViewController: UITableViewController, VisitorLoginViewDelegate {

    
    func userWillLogin() {
        print(__FUNCTION__)
        
        let oauth = OAuthViewController()
        
        let nav = UINavigationController(rootViewController: oauth)
      
        presentViewController(nav, animated: true, completion: nil)
        
    }
    
    
    func userWillRegister() {
        
         print(__FUNCTION__)
    }
    
    
    //用户是否登录的标记
    var userLogin = UserAccountViewModel().userLogin
    
    //新建属性访客视图
    var visitorLoginView: VisitorLoginView?

    //加载子视图 准备所有的视图层次关系
    //苹果专门为手吗开发准备的
    //如果检测到View（根视图）为nil 会自动调用LoadView
    
    override func loadView() {
        
        if userLogin {
            super.loadView()
        }else{
        //未登录执行
            setVisitorLoginView()
        }
    }
    
    private func setVisitorLoginView(){
        
        visitorLoginView = VisitorLoginView()
        view = visitorLoginView
        
        visitorLoginView?.visitorViewDelegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .Plain, target: self, action: "userWillLogin")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "userWillRegister")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
  
   

}
