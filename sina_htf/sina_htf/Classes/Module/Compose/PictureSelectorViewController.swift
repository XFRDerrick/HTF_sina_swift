//
//  PictureSelectorViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/24.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"
private let margin: CGFloat = 5
private let rowCount: CGFloat = 5

private let maxImageCount = 9

class PictureSelectorViewController: UICollectionViewController {

    var imageList = [UIImage]()
    
    init(){
        //设置layout
        //计算每一个Cell
        let itemW = (screenW - (rowCount + 1) * margin) / rowCount
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemW)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        //设置组间距
        layout.sectionInset = UIEdgeInsets(top: margin , left: margin, bottom: 0, right: margin)
        super.init(collectionViewLayout: layout)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(PictureSelectureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let delta = imageList.count == maxImageCount ? 0 : 1
        
        return imageList.count + delta
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PictureSelectureCell
    
        cell.delegate = self
        if indexPath.item == imageList.count {
            
            cell.image = nil
        
        }else{
            cell.image = imageList[indexPath.item]
        
        }
        return cell
    }

}
extension PictureSelectorViewController:PictureSelectureCellDelegate {

    
    func userWillDeletePicture(cell: PictureSelectureCell) {
        //获取当前Cell 对应的indexPath
        if let index = collectionView?.indexPathForCell(cell) {
            
            //删除数组中的对应indexPath的Image
            imageList.removeAtIndex(index.item)
            //刷新
            collectionView?.reloadData()
        }
  
        
    }
    
    
    func userWillChosePicture(cell: PictureSelectureCell) {
        //选中图片的操作
        if cell.image != nil {
            return
        }
        //得到图片选择器 控件
        let picker = UIImagePickerController()
        //modal出对应的图片选择器
        presentViewController(picker, animated: true, completion: nil)
        //会询问访问权限  是iOS7之后的 使用代理获取用户的个人隐私
        
        picker.delegate = self
        //一旦指定了代理对象 就需要程序员手动dismissController
        //设置允许编辑 上传用户头像的时候打开
//        picker.allowsEditing = true
        
    }
   
    
}

extension PictureSelectorViewController: UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    //获取图片
    /*
    - parameter picker:      图片选择器的本身
    - parameter image:       用户选择的图片
    - parameter editingInfo: 编辑信息
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print(editingInfo)
        print(image)
        
        imageList.append(image)
        //刷新
        collectionView?.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }

}


//MARK:- 定义协议

@objc protocol PictureSelectureCellDelegate: NSObjectProtocol {
    
    //协议方法
    optional func userWillChosePicture(cell: PictureSelectureCell)
    
    optional func userWillDeletePicture(cell: PictureSelectureCell)

}


//MARK:- 自定义Cell
class PictureSelectureCell: UICollectionViewCell {
    
    var image: UIImage? {
    
        didSet{
            //如果设置的图片为空的话 就隐藏删除按钮
            deleteBtn.hidden = image == nil
            addBtn.setImage(image, forState: .Normal)
           
        }
    }
    
    //MARK:- 添加图片 和删除图片的方法
    @objc private func addBtnDidClick(){
        
       
        delegate?.userWillChosePicture?(self)
        
    }
    @objc private func deleteBtnDidClick(){

        delegate?.userWillDeletePicture?(self)
        
    }
    
    //声明一个弱引用的代理对象
    weak var delegate: PictureSelectureCellDelegate?
    

    //MARK:-
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addBtn.imageView?.contentMode = .ScaleAspectFill
        contentView.addSubview(addBtn)
        contentView.addSubview(deleteBtn)
        
        //设置约束
        addBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        deleteBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(addBtn.snp_top)
            make.right.equalTo(addBtn.snp_right)
        }
        //绑定按钮的时间
        addBtn.addTarget(self, action: "addBtnDidClick", forControlEvents: .TouchUpInside)
        deleteBtn.addTarget(self, action: "deleteBtnDidClick", forControlEvents: .TouchUpInside)
        
    }
    //MARK:- 懒加载所有的子视图
    private lazy var deleteBtn: UIButton = UIButton(imageNameN: nil, imageNameH: nil, backImageNameN: "compose_photo_close", backImageNameH: "compose_photo_close")
    private lazy var addBtn: UIButton = UIButton(imageNameN: nil, imageNameH: nil, backImageNameN: "compose_pic_add", backImageNameH: "compose_pic_add_highlighted")
    
}



