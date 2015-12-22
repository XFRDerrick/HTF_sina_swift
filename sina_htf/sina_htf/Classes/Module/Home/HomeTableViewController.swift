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
        //设置tableVIew 只有登录之后才有tabView 才能对其进行设置更新
        prepareTableView()
        loadData()
        
    }

    //MARK:- 有关tabView的准备设置行高的设置
    private func prepareTableView(){
        
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: HomeCellId)
        //修改tableView的固定高度
//        tableView.rowHeight = 400
       
        //设置预估行高
        tableView.estimatedRowHeight = 300
        //设置行高自动计算
        tableView.rowHeight = UITableViewAutomaticDimension
        //设置分割线
        tableView.separatorStyle = .None
        
        //设置系统的下拉刷新
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        
//        tableView.tableFooterView = indicatorView
        
    }
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        //        indicator.startAnimating()
        return indicator
    }()
    
  //加载数据请求 不加@objc会崩溃
   @objc private func loadData(){
        
        let since_id = statuses.first?.id ?? 0
        //使用ViewModel
        StatusListViewModel.loadHomePageData(since_id) { (statues) -> () in
            self.refreshControl?.endRefreshing()
            guard let list = statues else {
                
                return
            }
            
            if since_id > 0 {
                //下拉刷新
                //拼接数组
                self.statuses = list + self.statuses
                
            }else{
                self.statuses = list
            }
            
            //执行刷新
            self.tableView.reloadData()
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
        //此处使用的TextLable是懒加载的
        //cell.textLabel?.text = statuses[indexPath.row].text
        
//        if !indicatorView.isAnimating() && indexPath.row == statuses.count - 1  {
//        //加载之前转动小花
//            indicatorView.startAnimating()
//            loadData()
//        } 
//        
        return cell
    }
    

}
