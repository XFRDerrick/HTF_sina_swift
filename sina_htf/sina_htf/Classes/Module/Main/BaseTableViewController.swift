//
//  BaseTableViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//


import UIKit

class BaseTableViewController: UITableViewController, VisitorLoginViewDelegate {

    //MARK:- 登录按钮的响应事件
    func userWillLogin() {
        print(__FUNCTION__)
        
        let oauth = OAuthViewController()
        
        let nav = UINavigationController(rootViewController: oauth)
      
        presentViewController(nav, animated: true, completion: nil)
        
    }
    
    //MARK:- 注册按钮的响应事件
    func userWillRegister() {
        
         print(__FUNCTION__)
    }
    
   //MARK:- 用户是否登录的标记
    var userLogin = UserAccountViewModel().userLogin
    
    //MARK:- 新建属性访客视图
    var visitorLoginView: VisitorLoginView?

    //加载子视图 准备所有的视图层次关系
    //苹果专门为手吗开发准备的
    //如果检测到View（根视图）为nil 会自动调用LoadView
    
    //MARK:- 加载视图层次的方法 apple
    override func loadView() {
        
        if userLogin {
            super.loadView()
        }else{
        //未登录执行
            setVisitorLoginView()
        }
    }
    //MARK:- 创建未登陆界面 方可视图界面
    private func setVisitorLoginView(){
        
        visitorLoginView = VisitorLoginView()
        view = visitorLoginView
        
        visitorLoginView?.visitorViewDelegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .Plain, target: self, action: "userWillLogin")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "userWillRegister")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  
   

}
