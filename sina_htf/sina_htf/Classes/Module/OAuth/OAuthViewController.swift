//
//  OAuthViewController.swift
//  sina_htf

//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SVProgressHUD
import AFNetworking
class OAuthViewController: UIViewController {
    
    
    let webView = UIWebView()
    
    // MARK: - 关闭按钮动作
    @objc private func close(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - 自动填充密码账号
    @objc private func defaultAccount(){
        
        let jsString = "document.getElementById('userId').value = 'hetengfei163@126.com' ,document.getElementById('passwd').value = '928hefei928'"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
        
    }
    
    
    // MARK: - 加载界面调用
    override func loadView() {
        view = webView
        
        //设置代理
        webView.delegate = self
    }
    // MARK: - 调用授权界面 设置导航条
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        loadAuthPage()
        setNavBar()
    }
    // MARK: - 解决取消授权弹出框不消失的bug
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    
    // MARK: - 加载授权界面方法
    private func loadAuthPage(){
        
        // 1  url 授权链接 将其
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        let url = NSURL(string: urlString)
        
        webView.loadRequest(NSURLRequest(URL: url!))
        
    }
    // MARK: - 设置导航条方法
    private func setNavBar(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "defaultAccount")
        
    }
    
}
// MARK: - webView的代理方法
extension OAuthViewController: UIWebViewDelegate {
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /**
     使用code获取token
     */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //屏蔽掉不需要的页面
        //根据请求的URL 屏蔽不希望加载的页面 和希望加载的界面
        guard let urlString = request.URL?.absoluteString else{
            
            return false
        }
        
        if urlString.hasPrefix("https://api.weibo.com/"){
            //希望加载的界面
            return true
        }
        if !urlString.hasPrefix("http://www.baidu.com"){
            //一定不是请求成功后的回调 同样不是希望加载的
            return false
        }
        //程序到这里一定是授权成功的URL
        
        let query = request.URL?.query
        //        print(query)
        
        if let q = query {
            
            let codeStr = "code="
            let code = q.substringFromIndex(codeStr.endIndex)
            print(code)
            
            //加载用户token
            loadAccssToken(code)
           
        }
        return true
    }
    

    //MARK: - 加载用户token （请求标识）
    private func loadAccssToken(code:String){
        
        UserAccountViewModel().loadAccssToken(code) { (isSuccess) -> () in
            if isSuccess {
                print("登录成功")
                //关闭
                self.close()
                
            }else{
            
                print("登录失败")
            }
        }
    
    }
    //MARK: - 获取用户信息
    private func loadUserInfo(account: UserAccount ){
        
        
    }
}



