//
//  StatusCell.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    
    //模型属性赋值
    var status: Status? {
        
        didSet{
            topView.status = status
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //自定义Cell
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
    
        //添加子视图
        contentView.addSubview(topView)
        
        contentView.addSubview(bottomView)
        
        //手动布局设置约束
        topView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
            //方便测试时设置
            //make.height.equalTo(100)
            
        }
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
