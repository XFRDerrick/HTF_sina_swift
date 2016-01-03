//
//  WebViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 16/1/4.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    //外部传入 urlString
    var urlString: String?
    
    let webView = UIWebView()
    
    override func loadView() {
         view = webView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage()
    }

    private func loadPage(){
    
        if let urlStr = urlString {
        
            let url = NSURL(string: urlStr)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            
        }
        
    }
  
    

}
