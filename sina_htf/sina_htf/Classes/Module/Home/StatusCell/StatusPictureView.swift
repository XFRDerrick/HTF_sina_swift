//
//  StatusPictureView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class StatusPictureView: UICollectionView {

    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     单图等比例显示
     多图的图片大小固定
     赌徒如果是四张 会按照2 * 2 显示
     多图其他数量按照3* 3宫格显示
     */
    
    private func setupUI() {}
  

}
