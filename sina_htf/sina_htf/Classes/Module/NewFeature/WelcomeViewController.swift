//
//  WelcomeViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/16.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit
//import SnapKit
import SDWebImage

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func loadView() {
        view = backImageView
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(view)
        showAnimation()
    }
    

    private func setupUI(){
    
        view.addSubview(iconView)
        view.addSubview(welcomeLable)
        
        //设置约束
        iconView.snp_makeConstraints { (make) -> Void in
           
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-200)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        welcomeLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
        
        //设置iconVIew对应的图片
        
        iconView.sd_setImageWithURL(UserAccountViewModel().headURL, placeholderImage: UIImage(named: "avatar_default_big"))
        
        //设置图片给的圆角
        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
        
        
    }
    
    //MARK:- 执行动画: 修改 iconView的底部约束
    private func showAnimation() {
        
        
        /*
        自动布局的页面实现动画效果需要注意
        1.不能够直接修改frame,可能会引起自动布局系统计算错误
        2.直接修改视图的约束关系.自动布局系统会根据约束关系 自动计算空间的frame  在layoutSubViews方法中计算视图的frame
        3.每一次运行循环开启时  自动布局系统都会  '收集' 所有页面视图的约束的修改 不会立即更新约束
        在运行循环结束前  会自动调用 layoutsubViews方法 修改所有子视图的frame
        
        4.如果希望提前更新约束 需要强制刷新页面 self.view.layoutIfNeeded() 需要在动画的闭包中执行 并且 一定要在修改约束之后调用
        */
        
        //设置label 透明度 为 0
        welcomeLable.alpha = 0
        // 弹簧系数 * 10 ~= 加速度  这个时候动画效果一般不会太奇葩
        
        //修改底部约束
        let offset =  -UIScreen.mainScreen().bounds.height + 200
        
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.98, initialSpringVelocity: 9.8, options: [], animations: { () -> Void in
            //执行约束的修改
            //自动布局 执行动画
            //强制刷新页面  将收集的所有的约束的更改 都执行页面 frame刷新
            //            self.view.layoutIfNeeded()
            self.iconView.snp_updateConstraints { (make) -> Void in
                make.bottom.equalTo(self.view.snp_bottom).offset(offset)
            }
            
            self.view.layoutIfNeeded()
            
            }) { (_) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.welcomeLable.alpha = 1
                    }, completion: { (_) -> Void in
                        print("OK")
                        
                        //动画结束的时候
                        
//                        NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootVCNotification, object: nil)
                        
                })
        }
    }

    
//MARK:- 懒加载所有的子视图
    
    private lazy var backImageView: UIImageView  = UIImageView(image: UIImage(named: "ad_background"))
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: ""))
    private lazy var welcomeLable: UILabel = {
    
        let lab = UILabel()
        
        lab.text = (UserAccountViewModel().userAccount?.name ?? "") + "欢迎回来"
        
        lab.font = UIFont.systemFontOfSize(16)
        
        lab.textColor = UIColor.lightGrayColor()
        
        lab.sizeToFit()
        return lab
    }()
    
    
}
