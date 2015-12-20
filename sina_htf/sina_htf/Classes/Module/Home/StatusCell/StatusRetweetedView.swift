//
//  StatusRetweetedView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/19.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SnapKit
//转发微博  转发微博正文 + 配图
class StatusRetweetedView: UIView {

    //约束属性
    var bottomConstraints: Constraint?
    
    //定义外部模型属性
    var retweetedStatus: Status?{
    
        didSet{
            retweetedLable.text = "@" + (retweetedStatus?.user?.name ?? "") + "\n" + (retweetedStatus?.text)! ?? "" 
            pictureView.imageURLs = retweetedStatus!.imageURLs
        
            //更新约束  卸载掉底部约束
            self.bottomConstraints?.uninstall()
            //根据视图更新
            if let urls = retweetedStatus?.imageURLs where urls.count > 0 {
            
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraints = make.bottom.equalTo(pictureView.snp_bottom).offset(StatusCellMarigin).constraint
                })
                
            } else {
                //没有配图的情况
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraints = make.bottom.equalTo(retweetedLable.snp_bottom).offset(StatusCellMarigin).constraint
                })
            }
            
        }
       
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        setupUI()
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
    
        addSubview(retweetedLable)
        addSubview(pictureView)
        
        retweetedLable.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self).offset(StatusCellMarigin)
        }
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLable.snp_bottom).offset(StatusCellMarigin)
            make.left.equalTo(retweetedLable.snp_left)
        }
        
        //自行计算pictureView行高
        self.snp_makeConstraints { (make) -> Void in
          //添加并记录
            self.bottomConstraints = make.bottom.equalTo(pictureView.snp_bottom).offset(StatusCellMarigin).constraint
        }
        
    }
    
    
    private lazy var retweetedLable: UILabel = UILabel(title: "转发微博", color: UIColor.darkGrayColor(), fontSize: 14, margin: StatusCellMarigin)
    
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    

}
