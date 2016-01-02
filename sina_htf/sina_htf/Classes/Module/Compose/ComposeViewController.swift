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

    //自定义表情键盘视图
    
    
    
    //响应方法 close
    @objc private func close(){
    
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//MARK:- 发送 写微博
    @objc private func sender(){
    
        //上传文本
        var urlString = "2/statuses/update.json"
        
        guard let token = UserAccountViewModel().token else{
            SVProgressHUD.showInfoWithStatus("请重新登录", maskType: .Gradient)
            return
        }
        
        let parameter = ["access_token": token, "status": textView.text ?? ""]
        
        if selectorVC.imageList.count != 0 {
            
            //上传图片
            urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
            let imageData = UIImagePNGRepresentation(selectorVC.imageList.first!)
            
            NetworkTools.sharedTools.upLoadImage(urlString, parameters: parameter, imageData: imageData!, finished: { (dict, error) -> () in
                
                self.finishedUpdataStatus(dict, error: error)
    
            })
            
        }else{
        
            //发布文本微博
            
            NetworkTools.sharedTools.requestJSONDict( .POST, urlString: urlString, parameters: parameter) { (dict, error) -> () in
                
                self.finishedUpdataStatus(dict, error: error)
            }
            
        }
    }
    //发送功能的方法抽取
    private func finishedUpdataStatus(dict: [String : AnyObject]?, error: NSError?) {
        if error != nil {
            
            SVProgressHUD.showInfoWithStatus("发布微博失败,请检查网络", maskType: .Gradient)
            return
        }
        SVProgressHUD.showSuccessWithStatus("发布微博成功", maskType: .Gradient)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if selectorVC.imageList.count == 0 {
            textView.becomeFirstResponder()
        }
        
    }
    
    
    @objc private func selectPicture(){
        
        //取消键盘的第一响应
        textView.resignFirstResponder()
        //显示图片选择器的视图

        selectorVC.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(screenH / 3 * 2)
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    @objc private func selectEmoticonKeyboard(){
        print(__FUNCTION__)
        
    }
    
    //MARK:- 懒加载子视图
    //创建图片选择视图
    private lazy var selectorVC: PictureSelectorViewController = PictureSelectorViewController()
   
    //文本编辑视图
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
   
    //键盘tool视图
    private lazy var toolBar: UIToolbar = UIToolbar()
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
}

//编辑文本视图的监听
extension ComposeViewController: UITextViewDelegate {

    //实时检测文本的改变使用
    func textViewDidChange(textView: UITextView) {
         //隐藏PlaceHolderLable
        placeHolderLaber.hidden = true
        //开启发送按钮的交互
        self.navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
}

//MARK:- set相关方法

extension ComposeViewController {

    private func setupUI(){
        
        setNavbBar()
        //在导航控制器 + ScrollView在自动布局中需要注意的事项
        //首先添加的约束 是从顶部开始添加约束 这时会自动开启 topLayoutGuide  srollView对应的contentInset.top = 64
        //如果首先添加的约束是从底部开始的 这个时候会自动开启 bottomlayoutGuide 输出rollView的对应contentInset.bottom = 44
        setTextView()
        setToolBar()
        
        setPictureSeletorVC()
        registerNotification()
        
    }
    
    private func setPictureSeletorVC(){
    
        addChildViewController(selectorVC)
        view.addSubview(selectorVC.view)
        
        //将toolbar 移动到视图的最顶层
        view.bringSubviewToFront(toolBar)
        //设置约束
        selectorVC.view.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(0)
        }
    
    }
    
    //注册键盘的通知 绑定toolBar
    private func registerNotification(){
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    //通知实现方法
    @objc private func keyboardWillChange(n: NSNotification){
    
        let duration = n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        let rect = (n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let curve = n.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int

        //更改toolBar的底部约束
        let offset = -screenH + rect.origin.y
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(offset)
        }
        
        UIView.animateWithDuration(duration) { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            self.view.layoutIfNeeded()
        }
        
    }
    //键盘辅助tool的设置
    private func setToolBar(){

        //给toolBar 设置items
        var  items = [UIBarButtonItem]()
        //向数组中添加元素
        let itemSettings = [["imageName": "compose_toolbar_picture","actionName":"selectPicture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background","actionName":"selectEmoticonKeyboard"],
            ["imageName": "compose_add_background"]]
        //遍 历配置的数组
        for item in itemSettings {
        
            let imageName = item["imageName"]
            
            let itemBtn = UIButton(imageNameN: imageName!, imageNameH:  (imageName! + "_highlighted"), backImageNameN: nil, backImageNameH: nil)
            
            if let action = item["actionName"] {
                
                itemBtn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
            }
            
            itemBtn.sizeToFit()
            
            let barButtonItem = UIBarButtonItem(customView: itemBtn)
            
            items.append(barButtonItem)
            //添加弹簧
            let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace , target: nil, action: nil)
            items.append(space)
            
        }

        items.removeLast()
        toolBar.items = items
        view.addSubview(toolBar)
        //设置布局
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }

    }
    
    //编辑文本视图的设置
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
    
    //顶部bar视图的设置
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

}

