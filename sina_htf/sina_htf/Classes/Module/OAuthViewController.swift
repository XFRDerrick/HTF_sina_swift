//
//  OAuthViewController.swift
//  sina_htf

//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SVProgressHUD

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
     - parameter request:         函数的内部参数
     - parameter shouldStartLoadWithRequest: 函数的外部参数
     */
    //返回ture可以正常工作
    
     /**
     不希望的：
    授权成功
         Optional(https://m.baidu.com/?code=cf7d1c8c96b522cffcd9379d860ae886&from=844b&vit=fps)
         
     注册页面
     Optional(https://api.weibo.com/oauth2/authorize?client_id=904005998&redirect_uri=http://www.baidu.com)
     Optional(http://weibo.cn/dpool/ttt/h5/reg.php?wm=4406&appsrc=1sgO8S&backURL=https%3A%2F%2Fapi.weibo.com%2F2%2Foauth2%2Fauthorize%3Fclient_id%3D904005998%26response_type%3Dcode%26display%3Dmobile%26redirect_uri%3Dhttp%253A%252F%252Fwww.baidu.com%26from%3D%26with_cookie%3D)
     Optional(http://m.weibo.cn/reg/index?jp=1&wm=4406&appsrc=1sgO8S&backURL=https%3A%2F%2Fapi.weibo.com%2F2%2Foauth2%2Fauthorize%3Fclient_id%3D904005998%26response_type%3Dcode%26display%3Dmobile%26redirect_uri%3Dhttp%253A%252F%252Fwww.baidu.com%26from%3D%26with_cookie%3D)
     
     
     希望的：
     授权界面
     Optional(https://api.weibo.com/oauth2/authorize?client_id=904005998&redirect_uri=http://www.baidu.com)
     请求授权界面
     Optional(https://api.weibo.com/oauth2/authorize)
     
     */
    
    
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
    
    private func loadAccssToken(code:String){
    
        
        
    }
    
    
}



