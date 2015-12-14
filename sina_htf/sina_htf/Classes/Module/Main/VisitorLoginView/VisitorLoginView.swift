//
//  VisitorLoginView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/13.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

//MARK:- 定义协议
  protocol VisitorLoginViewDelegate: NSObjectProtocol {

    //用户将要登录
    func userWillLogin()
    //用户将要注册
    func userWillRegister()
    
}

class VisitorLoginView: UIView {

    weak var visitorViewDelegate : VisitorLoginViewDelegate?
    
    func setupInfo(tipText:String, imageName: String?){
    
        tipLable.text = tipText
        if let name = imageName {
        
            circleView.image = UIImage(named: name)
            largeIcon.hidden = true
            //将Circle移动到视图的最顶层
            bringSubviewToFront(circleView)
        }else{
            //就是首页
            //开始动画
            startAnimation()
        }
    }
    //MARK:- 设置方可师徒中的房子周边的动画效果
    private func startAnimation(){
    
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 10.0
        anim.toValue = 2 * M_PI
        //当动画完毕后或者页面失去活跃状态 动画不移除
        anim.removedOnCompletion = false
        circleView.layer.addAnimation(anim, forKey: nil)
    }
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 添加视图中的子控件 并进行布局操作
    private func setupUI(){
        
        
        addSubview(circleView)
        addSubview(backView)
        addSubview(largeIcon)
        
        
        addSubview(tipLable)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        //使用自动布局
        for subView in subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -60))
        
        //添加圆圈的约束
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterX, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterY, multiplier: 1, constant: 0))
        
        //Lable
        addConstraint(NSLayoutConstraint(item: tipLable, attribute: .CenterX, relatedBy: .Equal, toItem: circleView, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLable, attribute: .Top, relatedBy: .Equal, toItem: circleView, attribute: .Bottom, multiplier: 1, constant: 16))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: tipLable, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 240))
        addConstraint(NSLayoutConstraint(item: tipLable, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60))
        
        //按钮的约束
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Left, relatedBy: .Equal, toItem: tipLable, attribute: .Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLable, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        //注册
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Right, relatedBy: .Equal, toItem: tipLable, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLable, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        //设置背景视图的约束 可视化的布局语言
        //OC 中可选项 一般使用 按位 或枚举选项  swift中直接指定数组
        //metrics:约束数值字典 [String: 数值],
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backView]-0-|", options: [], metrics: nil, views: ["backView": backView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backView]-(-35)-[regBtn]", options: [], metrics: nil, views: ["backView": backView,"regBtn":registerBtn]))
        
        //设置视图的背景颜色
        //UIColor(white: <#T##CGFloat#>, alpha: <#T##CGFloat#>) 设置灰度颜色
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        
        //添加点击事件
        registerBtn.addTarget(self, action: "registerBtnDidClick", forControlEvents: .TouchUpInside)
        loginBtn.addTarget(self, action: "loginBtnDidClick", forControlEvents: .TouchUpInside)
    
        
    }
    /**
     按钮的监听事件
     */
    //MARK:- 按钮的监听事件？？？
    @objc private func registerBtnDidClick(){
    
        visitorViewDelegate?.userWillRegister()
    }
    
    @objc private func loginBtnDidClick(){
    
    visitorViewDelegate?.userWillLogin()
    }
    
    
    //MARK:- 懒加载所有的子视图
     private lazy var backView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    private lazy var largeIcon : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var circleView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var tipLable: UILabel = {
    
        let lab = UILabel()
        
        lab.text = "关注一些人，回这里看看有什么惊喜，关注一些人，回这里看看有什么惊喜"
        
        lab.textColor = UIColor.darkGrayColor()
        
        lab.textAlignment = .Center
        
        lab.font = UIFont.systemFontOfSize(14)
        lab.numberOfLines = 0
        lab.sizeToFit()
        return lab
    }()
    
    private lazy var registerBtn: UIButton = {
    
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitle("注册", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(themeColor , forState: .Normal)
        btn.sizeToFit()
        
        return btn
    }()
    
    
    private lazy var loginBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitle("登录", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(themeColor , forState: .Normal)
        btn.sizeToFit()
        
        return btn
    }()
    

}
