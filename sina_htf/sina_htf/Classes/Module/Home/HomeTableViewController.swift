//
//  HomeTableViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/12.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

import AFNetworking

import SVProgressHUD

//import StatusCell


private let HomeCellId = "HomeCellId"

class HomeTableViewController: BaseTableViewController {
    
    //创建初始化对象
    private lazy var statuses = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userLogin {
            //没有登录的情况
              visitorLoginView?.setupInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: nil)
            return
        }
        //社会自tableVIew
        prepareTableView()
        loadData()
        
    }

    private func prepareTableView(){
        
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: HomeCellId)
        //修改tableView的固定高度
//        tableView.rowHeight = 400
        
        tableView.estimatedRowHeight = 300
        //设置行高自动计算
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        
    }
    
    
    
    //加载数据请求
    private func loadData(){
        
        let AFN = AFHTTPSessionManager()
        //get请求
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        guard let token = UserAccountViewModel().token else{
            
            print("token为nil")
            SVProgressHUD.showInfoWithStatus("请重新登录")
            return
        }
        
        let parameters = ["access_token" : token]

        AFN.GET(urlString, parameters: parameters, progress: { (p) -> Void in
//            print("home -> AFN -\(p)")
            
            }, success: { (task, result) -> Void in
    
                guard let dict = result as? [String : AnyObject] else{
                    print("数据不合法")
                    SVProgressHUD.showInfoWithStatus("网络出错请稍后再试")
                    return
                }
                //数据解析
                    if let array = dict["statuses"] as? [[String : AnyObject]]{
//                        print("array  ============================\n \(array)")
                        
                        var list = [Status]()
                        for item in array {
                            //遍历获取模型 存入模型
                            let s = Status(dict: item)
                            list.append(s)
                    
                        }
                        self.statuses = list
                        
                        //刷新表格
                        self.tableView.reloadData()
                    }
                
            }) { (task, error) -> Void in
                print("hpme -\(error)")
        }
        
    }
    
}

// MARK: - Table view data source
extension HomeTableViewController{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //IOS 6.0 推出的方法
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellId , forIndexPath: indexPath)  as! StatusCell
        
        cell.status = statuses[indexPath.row]
        
        print(statuses[indexPath.row].imageURLs?.count)
        //此处使用的TextLable是懒加载的
        //cell.textLabel?.text = statuses[indexPath.row].text
        
        return cell
    }
    

}
