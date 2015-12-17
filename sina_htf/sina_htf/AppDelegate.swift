//
//  AppDelegate.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/12.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //需要创建window
        // 是否登录
//        let account = UserAccount.loadAccount()
//        print("是否存储登陆过----\(account)")
        
        //判断是否是新的版本
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.makeKeyAndVisible()
        //注册通知
        registerNotification()
        
        //设置根控制器
        window?.rootViewController = defaultViewController()
        
        return true
    }
    
    //MARK:- 切换视图控制器的通知
    private func registerNotification(){
        //是个单例对象 程序一运行就会建立
        //注册 切换视图控制器的通知 Object： nil 对应广播
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootVC:", name:WBSwitchRootVCNotification , object: nil)
        
        
    }
    //移除通知的操作，写于不写没有区别只是编码习惯问题
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    // @objc 的用法 只要OC中 target - action 这种消息机制 selector类型都需要@objc来兼容
    @objc private func switchRootVC(n: NSNotification) {
        
        print("根据通知切换控制器 ：\(n)")
        //根据发送的通知切换对应的根视图
        if  n.object != nil {
            //跳转到welcome
            window?.rootViewController = WelcomeViewController()
            return
        }
        window?.rootViewController = MainViewController()
        
    }
    
    
    //MARK:- 根据判断是否登录显示具体的页面
    private func defaultViewController()-> UIViewController {
        
        if UserAccountViewModel().userLogin {
            
            return  isNewVersion() ? NewFeatureViewController() :WelcomeViewController()
        }
        
        //用户没有登录的
        return MainViewController()
    }
    
    
    //MARK:- 判断是否是新版本
    private func isNewVersion() -> Bool{
        //获取当前版本
        let info = NSBundle.mainBundle().infoDictionary
        let currentVersionStr = info!["CFBundleShortVersionString"] as! String
        //转换成格式
        let currentNum = Double(currentVersionStr)
        print(currentNum)
        
        //本地缓存的版本
        //使用userDefaults 来存储版本
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let sandBoxKey = "sandBoxKey"
        let lastNum = userDefaults.doubleForKey(sandBoxKey)
        
        //立即存储当前版本
        userDefaults.setDouble(currentNum!, forKey: sandBoxKey)
        userDefaults.synchronize()
        
        //比较版本
        print("currentNum = \(currentNum!)")
        print("lastNum = \(lastNum)")
        
        return currentNum! > lastNum
    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

