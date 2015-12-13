//
//  OAuthViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    
    let webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        //社会自代理
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = webView
        loadAuthPage()
        setNavBar()
        
    }

    
    // MARK: - 加载授权界面
    private func loadAuthPage(){
    
        
        // 1  url 授权链接 将其
//        let urlString = " 还未获取链接 "
//        let url = NSURL(string: urlString)
//        
//        webView.loadRequest(NSURLRequest(URL: url!))
//        
    
    }
     // MARK: - 设置导航条
    private func setNavBar(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}
// MARK: - <##>
extension OAuthViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    //返回ture可以正常工作
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return false
    }
    
    
}



