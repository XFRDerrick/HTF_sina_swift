//
//  ComposeViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/23.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SVProgressHUD

class ComposeViewController: UIViewController {

    //响应方法 close
    @objc private func close(){
    
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @objc private func sender(){
    
        let urlString = "2/statuses/update.json"
        
        guard let token = UserAccountViewModel().token else{
        SVProgressHUD.showInfoWithStatus("请重新登录", maskType: .Gradient)
            return
        }
        let parameter = ["access_token": token, "status": textView.text ?? ""]
        
        NetworkTools.sharedTools.requestJSONDict( .POST, urlString: urlString, parameters: parameter) { (dict, error) -> () in
            if error != nil {
            
                SVProgressHUD.showInfoWithStatus("发布微博失败,请检查网络", maskType: .Gradient)
                return
            }
            SVProgressHUD.showSuccessWithStatus("发布微博成功", maskType: .Gradient)
           
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        setupUI()
        
    }

    private func setupUI(){
    
        setNavbBar()
        setTextView()
    
    }
    private func setTextView(){
        
        view.addSubview(textView)
        //设置约束
        textView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(200)
        }
        //给textView添加站位的文本
        textView.addSubview(placeHolderLaber)
    
        placeHolderLaber.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView).offset(8)
            make.left.equalTo(textView).offset(5)
        }
        
    
    }
    
    

    private func setNavbBar(){
    
        //设置导航条
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "sender")
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //自定义title
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        navigationItem.titleView = titleView
        
        let titleLable = UILabel(title: "发微博", color: UIColor.darkGrayColor(), fontSize: 17)
        let nameLable = UILabel(title: UserAccountViewModel().userAccount?.name ?? "", color: UIColor.lightGrayColor(), fontSize: 14)
        
        titleView.addSubview(titleLable)
        titleView.addSubview(nameLable)
        
        //设置约束
        titleLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_top)
            make.centerX.equalTo(titleView.snp_centerX)
        }
        nameLable.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(titleView.snp_bottom)
            make.centerX.equalTo(titleView.snp_centerX)
        }
        
    }
    
    //懒加载子视图
    private lazy var textView: UITextView = {
    
        let tv = UITextView()
//        tv.text = "请输入新鲜事"
        tv.font = UIFont.systemFontOfSize(14)
        tv.backgroundColor = UIColor.randomColor()
        
        tv.alwaysBounceVertical = true
        tv.keyboardDismissMode = .OnDrag
        
        tv.delegate = self
        return tv
    
    }()
    
    //占位文本
    private lazy var placeHolderLaber: UILabel = UILabel(title: "请输入新鲜事", color: UIColor.lightGrayColor(), fontSize: 18)
    
}

extension ComposeViewController: UITextViewDelegate {

    //实时检测文本的改变使用
    func textViewDidChange(textView: UITextView) {
         //隐藏PlaceHolderLable
        placeHolderLaber.hidden = true
        //开启发送按钮的交互
        self.navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
}

