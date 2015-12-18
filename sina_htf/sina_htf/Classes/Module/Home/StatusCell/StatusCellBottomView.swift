//
//  StatusCellBottomView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {

    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
//        backgroundColor = UIColor(white: 0.3, alpha: 1)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        
        addSubview(retweetedBtn)
        addSubview(composeBtn)
        addSubview(likeBtn)
        
       //MARK:- 设置约束
        retweetedBtn.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self)
        }
        composeBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetedBtn.snp_right)
            make.top.bottom.equalTo(self)
            make.width.equalTo(retweetedBtn.snp_width)
        }
        likeBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(composeBtn.snp_right)
            make.right.equalTo(self.snp_right)
            make.top.bottom.equalTo(self)
            make.width.equalTo(composeBtn.snp_width)
        }

        let sepView1 = sepView()
        
        let sepView2 = sepView()
        
        //添加
        addSubview(sepView1)
        addSubview(sepView2)
        //设置约束
        let w = 0.5
        let scale = 0.4
        
        sepView1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetedBtn.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(w)
        }
        sepView2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(composeBtn.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(w)
        }
        
    }
     //MARK:- 生成分割线的方法
    private func sepView() -> UIView{
        let v = UIView()
        v.backgroundColor = UIColor.darkGrayColor()
        return v
    }
    
    
    
    //MARK:- 懒加载视图
    
    private lazy var retweetedBtn: UIButton = UIButton(backImageNameN: nil, backImageNameH: nil, color: UIColor.darkGrayColor(), title: "转发", fontOfSize: 10, imageName: "timeline_icon_retweet")
    
    private lazy var composeBtn: UIButton = UIButton(backImageNameN: nil, backImageNameH: nil, color: UIColor.darkGrayColor(), title: "评论", fontOfSize: 10, imageName: "timeline_icon_comment")
    
    private lazy var likeBtn: UIButton = UIButton(backImageNameN: nil, backImageNameH: nil, color: UIColor.darkGrayColor(), title: "赞", fontOfSize: 10, imageName: "timeline_icon_unlike")

   
    
}
