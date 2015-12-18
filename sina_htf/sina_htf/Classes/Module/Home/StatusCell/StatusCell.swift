//
//  StatusCell.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

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
        //手动布局设置约束
        topView.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(contentView.snp_top)
//            make.left.equalTo(contentView.snp_left)
            
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(100)
            
        }
        
    
    }
    

    
    //MARK：- 懒加载子视图
    private lazy var topView :StatusCellTopView = StatusCellTopView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
