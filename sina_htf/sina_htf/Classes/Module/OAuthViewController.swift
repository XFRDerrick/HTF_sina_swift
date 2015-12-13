//
//  OAuthViewController.swift
//  sina_htf
//
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
//extension
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
     注册URL不希望加载
     http://weibo.cn/dpool/ttt/h5/reg.php?wm=4406&appsrc=1sgO8S&backURL=https%3A%2F%2Fapi.weibo.com%2F2%2Foauth2%2Fauthorize%3Fclient_id%3D904005998%26response_type%3Dcode%26display%3Dmobile%26redirect_uri%3Dhttp%253A%252F%252Fwww.baidu.com%26from%3D%26with_cookie%3D)
     Optional(http://m.weibo.cn/reg/index?jp=1&wm=4406&appsrc=1sgO8S&backURL=https%3A%2F%2Fapi.weibo.com%2F2%2Foauth2%2Fauthorize%3Fclient_id%3D904005998%26response_type%3Dcode%26display%3Dmobile%26redirect_uri%3Dhttp%253A%252F%252Fwww.baidu.com%26from%3D%26with_cookie%3D
     
     */
    
    
     /**
         请求授权界面希望加载
         Optional(https://api.weibo.com/oauth2/authorize)
     
         Optional(https://api.weibo.com/oauth2/authorize?client_id=904005998&redirect_uri=http://www.baidu.com#)
     
     */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.URL)
        return true
    }
    
    
}



