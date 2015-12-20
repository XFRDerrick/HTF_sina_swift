//
//  StatusPictureView.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/18.
//  Copyright © 2015年 hetefe. All rights reserved.
//

//import Snap
import UIKit
private let pictureCellID: String =  "pictureCellID"
private let pictureCellMargin: CGFloat =  5

class StatusPictureView: UICollectionView {
    //定义外部数据属性
    var imageURLs: [NSURL]? {
        
        didSet{
            //修改配图视图的大小
            let pSize = caclePictureViewSize()
            
            self.snp_updateConstraints { (make) -> Void in
                make.size.equalTo(pSize)
            }

            //修改测试的文案
            testLable.text = "\(imageURLs?.count ?? 0)"
            //刷新列表
            reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        //实例化一个流水布局
        let flowLayout = UICollectionViewFlowLayout()
        //设置间距
        flowLayout.minimumInteritemSpacing = pictureCellMargin
        flowLayout.minimumLineSpacing = pictureCellMargin
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        backgroundColor = UIColor.whiteColor()
        
        //注册Cell
        registerClass(PictureCell.self, forCellWithReuseIdentifier: pictureCellID)
        
        //设置数据源
        self.dataSource = self
        
        setupUI()
        
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
    
    private func caclePictureViewSize() -> CGSize{
        
        //获取配图的数量
        let iamgeCount = imageURLs?.count ?? 0
        
        //获取配图的最大宽度
        let maxWidth = screenW - 2 * StatusCellMarigin
        //MARK:- 据推测为线宽影响 减一解决布局问题
        let itemWidth = (maxWidth - 2 * pictureCellMargin - 1) / 3
        
        //流水视图取出
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        //设置itemSize
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth)
        //没有图片
        if iamgeCount == 0{
            return CGSizeZero
        }
        //单张图片
        if iamgeCount == 1 {
            //TODO: 单图会按照图片等比例显示
            //先固定尺寸
            let imageSize = CGSize(width: 180, height: 120)
            layout.itemSize = imageSize
            
            return imageSize

        }
        //单张图片
        if iamgeCount == 4 {
            let w = itemWidth * 2 + pictureCellMargin
            return CGSize(width: w, height: w)
        }
        //程序走到这里表示其他的情况
        
        //  确定有多少行
        let row :CGFloat = CGFloat((iamgeCount - 1) / 3 + 1)
        
        return CGSize(width: maxWidth, height: row * itemWidth + (row - 1) * pictureCellMargin)
    
    }
    
    private func setupUI() {
        
            addSubview(testLable)
            
            testLable.snp_makeConstraints { (make) -> Void in
                make.center.equalTo(self.snp_center)
        
        }
      
    }
    // MARK:懒加载所有的子视图
    private lazy var testLable: UILabel = UILabel(title: "", color: UIColor.redColor(), fontSize: 30)

}

extension StatusPictureView: UICollectionViewDataSource {


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier(pictureCellID, forIndexPath: indexPath) as! PictureCell
        
//        cell.backgroundColor = UIColor.randomColor()
        
        cell.imageURL = imageURLs![indexPath.item]
        
        return cell
        
    }

}

//MARK:- 自定义Cell使用时去注册
class PictureCell: UICollectionViewCell {

    //外部属性
    var imageURL: NSURL? {
    
        didSet{
           iconImageView.sd_setImageWithURL(imageURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
  
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI(){
    
        contentView.addSubview(iconImageView)
        
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    
    }
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
       //显示图片的原比例 但是图片会被裁减
        //scaleTOFill 会被压缩或者拉伸
        iv.clipsToBounds = true
        iv.contentMode = UIViewContentMode.ScaleAspectFill
        //使用 sb / xib 默认设置剪裁
        return iv
    }()

    

}



