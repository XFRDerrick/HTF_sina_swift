//
//  StatusCell.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

 //转发 ：顶部视图 + 转发视图 + 底部视图

import UIKit

import SnapKit

class StatusCell: UITableViewCell {
   
    
    var bottomViewTopConstraints: Constraint?
    //模型属性赋值
    var status: Status? {
        
        didSet{
            
            topView.status = status
            
            //卸载掉约束
            bottomViewTopConstraints?.uninstall()
            //根据模型是否显示转发模型
            if let retweetedStatus = status?.retweeted_status {
                
                retweetedView.retweetedStatus = retweetedStatus
                bottomView.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomViewTopConstraints = make.top.equalTo(retweetedView.snp_bottom).constraint
                })
                
                retweetedView.hidden = false
                
            }else{
                bottomView.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomViewTopConstraints = make.top.equalTo(topView.snp_bottom).constraint
                })
                retweetedView.hidden = true
            }
            
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //自定义Cell
        setupUI()
        
        self.selectionStyle = .None
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
    
//        self.retweetedView.removeFromSuperview()
        //添加子视图
        contentView.addSubview(topView)
        
        contentView.addSubview(bottomView)
        
        contentView.addSubview(retweetedView)
        //手动布局设置约束
        topView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
            //方便测试时设置
            //make.height.equalTo(100)
            
        }
        //转发微博约束
        retweetedView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom)
            make.left.right.equalTo(contentView)
            
//            make.height.equalTo(60)
        }
        
        
        bottomView.snp_makeConstraints { (make) -> Void in
           
            self.bottomViewTopConstraints = make.top.equalTo(retweetedView.snp_bottom).constraint
             make.left.right.equalTo(topView)
            make.height.equalTo(50)
        }
        
        
        //MARK:- 自定义行高未完善
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
        
    
    }
    

    
    //MARK：- 懒加载子视图
    private lazy var topView :StatusCellTopView = StatusCellTopView()
    private lazy var bottomView :StatusCellBottomView = StatusCellBottomView()
    
    private lazy var retweetedView: StatusRetweetedView = StatusRetweetedView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
