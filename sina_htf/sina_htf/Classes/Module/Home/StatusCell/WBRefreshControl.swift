//
//  WBRefreshControl.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/22.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SnapKit

//下拉状态的枚举
enum WBRefreshStatue:Int {
    //默认状态
    case Normal = 0
    //下拉临界状态 还未松手
    case Pulling = 1
    //正在刷新的状态
    case Refreshing = 2
}

//刷新控件的高度
private let RefreshViewHeight: CGFloat = 60

class WBRefreshControl: UIControl {
    
    //定义属性保存上一次刷新的状态
    var oldStatue: WBRefreshStatue = .Normal
    
    //定义外部模型属性
    var statue: WBRefreshStatue = .Normal {
    
        didSet{
            switch statue {
            
            case .Pulling:
                tipLable.text = "准备起飞"
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
                
            case .Refreshing:
                tipLable.text = "正在起飞"
                //隐藏箭头显示转动小菊花
                arrowIcon.hidden = true
                loadIcon.startAnimating()
                
                //修改contentView 调整动画效果停留
                var inset = scrollView!.contentInset
                inset.top += RefreshViewHeight
                scrollView?.contentInset = inset
               
                sendActionsForControlEvents(.ValueChanged)
            case .Normal:
                tipLable.text = "下拉起飞"
                arrowIcon.hidden = false
                loadIcon.stopAnimating()
                
                //修改contentView 调整动画效果停留
                if oldStatue == .Refreshing {
                    var inset = scrollView!.contentInset
                    inset.top -= RefreshViewHeight
                    scrollView?.contentInset = inset
                }
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformIdentity
                })
                
            }
            //所有的实质结束后保存刷新状态
            oldStatue = statue
        }
    }
    
    //实现kvo方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        //1 获取tableView的临界值
        let insetTop = scrollView?.contentInset.top ?? 0
        let condationValue = RefreshViewHeight + insetTop
        
        //2 获取tableView的contentOffset
        let offsetY = scrollView?.contentOffset.y ?? 0
        
        if scrollView!.dragging {
        
            if statue == .Normal && offsetY < condationValue {
                //下来小于临界值
                statue = .Pulling
            }else if statue == .Pulling && offsetY > condationValue {
                //进入默认状态
                statue = .Normal
            }
        }else{
            //如果不是在拉拽状态 当前的视图是status是pulling状态在 执行刷新操作
            if statue ==  .Pulling {
                statue = .Refreshing
            }
        
        }
        
       
        //3 比较对应的临界值 和位移 的大小
        
    }
    func endRefreshing(){
        
        statue = .Normal
    }
    
    
    //MARK:- View 的生命周期方法
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willRemoveSubview(newSuperview!)
        //可以获取到当前控件的父视图
        //1 获取tableView
        if let myFather = newSuperview as? UIScrollView {
            //如果父视图能够转化为 滚动视图
            self.scrollView = myFather
            //设置kvo
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
        
    }
    //移除kvo观察
    deinit{
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    //定义属性 记录父视图
    var scrollView: UIScrollView?
    
    //MARK: 重写构造方法
    override init(frame: CGRect) {
        //由于视图frame固定  在内部指定frame
        let rect = CGRect(x: 0, y: -RefreshViewHeight, width: screenW, height: 60)
        super.init(frame: rect)
        setupUI()
        backgroundColor = UIColor.randomColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addSubview(tipLable)
        addSubview(arrowIcon)
        addSubview(loadIcon)
        
        //设置约束
        tipLable.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(15)
            make.centerY.equalTo(self.snp_centerY)
        }
        arrowIcon.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(tipLable.snp_left).offset(-5)
            make.centerY.equalTo(tipLable.snp_centerY)
        }
        loadIcon.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(arrowIcon)
        }
    }
    
    
    //MARK:- 懒加载所有的子视图
    private lazy var arrowIcon: UIImageView = UIImageView(image: UIImage(named: "compose_mentionbutton_background_highlighted"))
    
    private lazy var tipLable: UILabel = UILabel(title: "下拉飞飞", color: UIColor.randomColor(), fontSize: 13)
    private lazy var loadIcon: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    

}
