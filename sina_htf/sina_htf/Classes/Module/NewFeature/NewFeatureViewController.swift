//
//  NewFeatureViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/16.
//  Copyright © 2015年 hetefe. All rights reserved.
//



import UIKit
import SnapKit

private let imageCount = 4


private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    
    //不需要添加override
    //构造方法只能够向上继承一个层级 不能透过父类找父类的父类
    init(){
        //指定流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        
        
        //修改视图滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        //super是构造的最后一步
        super.init(collectionViewLayout: layout)
        
        //注意设置位置 应在super之下  构造完成后才能获取其属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        
        //取消弹簧
        collectionView?.bounces = false
        
    }
    //自动补全
    //如果当前视图通过XIB、sb加载程序就会崩溃
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.index = indexPath.item
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        //Cell展示完成之后 对应的是显示的上一个的indexPath 不能获取使用indexPath获取Cell
//        print(indexPath.item)
        let cell = collectionView.visibleCells().last as! NewFeatureCell
        
        //获取Cell的哦indexPath
        let index = collectionView.indexPathForCell(cell)
        
        if index!.item == imageCount - 1 {
        
            //执行动画
            cell.showAnimation()
        }
        
    }
    
    
    
}







//MARK:- 创建一个新的类Cell

class NewFeatureCell: UICollectionViewCell {
    
    //添加index属性 为Cell赋值
    var index: Int = 0{
        
        didSet{
            //和OC中的Set是一样的
            iconView.image = UIImage(named: "new_feature_\(index + 1)")
            
            //隐藏其他界面的btn
            startBtn.hidden = true
            
        }
        
    }
    
    
    
    //重写构造方法 cell 构造的入口
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //按钮的动画效果
    private func showAnimation(){
        
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        //在动画的闭包中 让button修改 按钮的形变
    
        /**
        - parameter <Tduration:             动画持续时间
        - parameter delay:                  动画延时时间
        - parameter usingSpringWithDamping: 弹簧系数 是区间 越小越弹
        - parameter initialSpringVelocity:  加速度
        - parameter options:                动画的可选项
        - parameter animations:             执行动画的闭包
        - parameter completion:             动画执行完成的闭包
        */
        
        startBtn.hidden = false
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
             self.startBtn.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
//                print("OK")
        }
    }
    
    //MARK:- 新特性按钮点击事件
    @objc private func startBtnDidClick(){

        NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootVCNotification, object: nil)
        
    }
    
    
    private func setupUI(){
        
        //添加子视图 自定义的子视图要添加在contentVIew上
        contentView.addSubview(iconView)
        //需要使用snapKit 布局
        iconView.snp_makeConstraints { (make) -> Void in
            //Make表示需要添加约束的对象
            make.edges.equalTo(contentView.snp_edges)
            
        }
        contentView.addSubview(startBtn)
        startBtn.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView.snp_bottom).offset(-160)
        })
        
        //添加按钮的点击时间
        
        startBtn.addTarget(self, action: "startBtnDidClick", forControlEvents: .TouchUpInside)
    }
    
    //MARK:- Cell创建子视图
    private lazy var iconView : UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    
    //开始按钮
    private lazy var startBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState:.Highlighted )
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
        
        btn.setTitle("开始体验", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        //设置大小
        btn.sizeToFit()
        return btn
        
    }()
    
    
}



