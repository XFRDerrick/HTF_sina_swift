//
//  StatusCell.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import SnapKit

let StatusCellMargin: CGFloat = 12

let StatusCellImageWidth: CGFloat = 35


class StatusCell: UITableViewCell {
    
    //Cell的底部约束
    
    //添加模型
    var status: Status? {
    
        didSet{
            
        
        
        }
    
    
    }

    
    
    
    
    
//    private lazy var originalView : Status
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
