//
//  StatusCellTopView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SDWebImage

import SnapKit

class StatusCellTopView: UIView {
   
    
    //定义视图 的底部约束的属性
    var bottomConstraints: Constraint?
    
    //模型属性赋值
    var status: Status? {
        
        didSet{
            
            iconImage.sd_setImageWithURL(status?.user?.headURL)
            nameLable.text = status?.user?.name
            mbrankImage.image = status?.user?.mbrankImage
            verified_type_image.image = status?.user?.verified_type_image
            //TODO: 后续完善
            timeLable.text = status?.created_at
            sourceLable.text = status?.source
            
            contentLable.text = status?.text
            
            //设置配图视图的 图片数组的数据源
            pictureView.imageURLs = status?.imageURLs
            //需要根据是否有配图 动态调整约束关系
            //更新之前需将原来的取消掉
            self.bottomConstraints?.uninstall()
            if let urls = status?.imageURLs where urls.count > 0{
                //有配图的时候
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraints = make.bottom.equalTo(pictureView.snp_bottom).offset(StatusCellMarigin).constraint
                })
            }else{
                //对顶部视图的底部设置约束 没有配图的情况
                self.snp_updateConstraints(closure: { (make) -> Void in
                      self.bottomConstraints = make.bottom.equalTo(contentLable.snp_bottom).offset(StatusCellMarigin).constraint
                })
            }
        }
    }
    
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
//        backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- 自定义顶部视图
    private func setupUI(){
        
        addSubview(sepView)
        //头像 title VIP  time  where
        addSubview(iconImage)
        addSubview(nameLable)
        addSubview(mbrankImage)
        addSubview(verified_type_image)
        addSubview(timeLable)
        addSubview(sourceLable)
        addSubview(contentLable)
        //添加对应的约束
        sepView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        sepView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.height.equalTo(10)
        }
        
        iconImage.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(StatusCellMarigin)
            make.top.equalTo(sepView.snp_top).offset(StatusCellMarigin)
            make.size.equalTo(CGSize(width: StatusCellHeadIMageWidth, height: StatusCellHeadIMageWidth))
        }
        nameLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImage.snp_top)
            make.left.equalTo(iconImage.snp_right).offset(StatusCellMarigin)
        }
        mbrankImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLable.snp_top)
            make.left.equalTo(nameLable.snp_right).offset(StatusCellMarigin)
        }
        verified_type_image.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconImage.snp_right)
            make.centerY.equalTo(iconImage.snp_bottom)
        }
        timeLable.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImage.snp_bottom)
            make.left.equalTo(iconImage.snp_right).offset(StatusCellMarigin)
        }
        sourceLable.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImage.snp_bottom)
            make.left.equalTo(timeLable.snp_right).offset(StatusCellMarigin)
        }
        contentLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImage.snp_bottom).offset(StatusCellMarigin)
            make.left.equalTo(self.snp_left).offset(StatusCellMarigin)
            
        }
        
        //添加collectionView配图视图
        addSubview(pictureView)
        //设置约束
        pictureView.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(contentLable.snp_bottom).offset(StatusCellMarigin)
            make.left.equalTo(contentLable.snp_left)
            //TODO: 为picture设置Size
//            make.size.equalTo(CGSize(width: 100, height: 100))
            
        }
        
//        对顶部视图的底部设置约束 并且设置标记属性
        self.snp_makeConstraints { (make) -> Void in
            self.bottomConstraints = make.bottom.equalTo(pictureView.snp_bottom).offset(StatusCellMarigin).constraint
        }
        
        
        
    }
    //MARK:- 懒加载所有的子视图
    private lazy var sepView: UIView = UIView()
    
    private lazy var iconImage: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var nameLable: UILabel = UILabel(title: "你是sb", color: themeColor, fontSize: 14)
    private lazy var mbrankImage: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    private lazy var verified_type_image = UIImageView(image: UIImage(named: "avatar_vip"))
    private lazy var timeLable: UILabel = UILabel(title: "20分钟前", color: themeColor, fontSize: 10)
    private lazy var sourceLable: UILabel = UILabel(title: "一点资讯", color: themeColor, fontSize: 10)
    private lazy var contentLable: UILabel = UILabel(title: "炸鸡啤酒炸鸡啤酒炸鸡啤酒炸鸡啤酒", color: UIColor.darkGrayColor(), fontSize: 14,margin: StatusCellMarigin)
    
    //添加配图视图
    private lazy var pictureView: StatusPictureView = StatusPictureView()
      
}
