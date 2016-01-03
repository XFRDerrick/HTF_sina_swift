//
//  EmoticonManager.swift
//  EmotionalKeyBoard
//
//  Created by 赫腾飞 on 15/12/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

//负责 从 plist  加载表情数据

class EmoticonManager: NSObject {
    
    //分组表情数组
    lazy var packages = [EmoticonPackages]()
    
    override init() {
        
        super.init()
        loadEmoticon()
        
        
    }
    
    func statusTextToImagwText(str: String, font: UIFont) -> NSAttributedString {
        
        let pattern = "\\[.*?\\]"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        // 需要表情数组 表情文字 在 表情数据源中 查找 表情模型
        // matchesInString  会进行多次查找
        let results = regex.matchesInString(str, options: [], range: NSRange(location: 0, length: str.characters.count))
        //遍历结果集   倒序
        var index = results.count - 1
        //获取表情数据源的数组
        let strM = NSMutableAttributedString(string: str)
        while index >= 0 {
            let result = results[index]
            let range = result.rangeAtIndex(0)
            let subStr = (str as NSString).substringWithRange(range)
            //            print(subStr)
            //获取到表情模型
            if let em = getEmoticonWithEmoticonText(subStr) {
                //表情模型 中 有图片地址
                
                
                let imageText = EmoticonTextAttachment().emoticonTextToImageText(em,font: font)
                //将图片转换为 附件 -> 富文本
                strM.replaceCharactersInRange(range, withAttributedString: imageText)
            }
            
            index--
        }
        //替换富文本
        return strM
    }
    
    private func getEmoticonWithEmoticonText(str: String) -> Emoticon? {
       
        let packages = EmoticonManager().packages
        for p in packages {
            //filter  过滤 滤镜
            
            let emoticones = p.emoticons.filter({ (em) -> Bool in
                //返回一个过滤条件
                return em.chs == str
            })
            
            if emoticones.count != 0 {
                return emoticones.last
            }
        }
        
        return nil
    }
    
    func loadEmoticon(){
    
        //获取对应的bundle 文件目录 inDirectory 间接的
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")

        guard let filePath = path else {
            
            print("文件目录不存在")
            return
        }
        //加载plist文件 转换为字典 获取的是最外的info plist
        let dict = NSDictionary(contentsOfFile: filePath)!
        
        //获取字典中的数据遍历数据
        if let array = dict["packages"] as? [[String: AnyObject]] {
        
            //遍历数组 获取id
            for item in array {
                
                let id = item["id"] as! String
                //获取分组目录中的info.plist id 是文件夹名
                
                loadGroupEmoticons(id)
            }
        }
    }
    
    private func loadGroupEmoticons(id: String) {
    
        let path = NSBundle.mainBundle().pathForResource("Info.plist", ofType: nil, inDirectory: "Emoticons.bundle/\(id)")
        guard let filePath = path else{
        
            print("文件不存在")
            return
        }
        //MARK:- 加载到info.plist文件 存储的是字典
        
        let dict = NSDictionary(contentsOfFile: filePath)
        
        //获取字典中的表情数组 key =  emoticons 对应的数组
        
        //获取三个表情包名
        let group_name_cn = dict!["group_name_cn"] as! String
        //三个表情包里的表情
        let array = dict!["emoticons"] as! [[String: String]]
        //实例化packages 
        let p = EmoticonPackages(id: id, group_name_cn: group_name_cn, array: array)
        packages.append(p)
        
    }
    

}
