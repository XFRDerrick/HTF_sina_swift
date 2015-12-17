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

class HomeTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        visitorLoginView?.setupInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: nil)
        
        loadData()
        
    }
       /*
    private func loadData() {
        //实现网络请求
        let AFN = AFHTTPSessionManager()
        //get请求
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //判断token是否为空
        guard let token = UserAccountViewModel().token else {
            print("token为空")
            SVProgressHUD.showInfoWithStatus("请重新登陆")
            return
        }
        let parameters = ["access_token" : token]
        AFN.GET(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (task, result) -> Void in
                //需要判断result 能否转化为字典
                if let dict = result as? [String : AnyObject] {
                    //算数据获取成功
                    //通过的键值的方式 获取 statuses对应的数组
                    if let array = dict["statuses"] as? [[String : AnyObject]] {
                        print("--------------------" ,array)
                        //TODO: 遍历数组中 所有的字典 做字典转模型的操作
                        
                    }
                }
            }) { (task, error) -> Void in
                print(error)
        }
    }
*/
    

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
        
        print(token)
        AFN.GET(urlString, parameters: parameters, progress: { (p) -> Void in
            print("home -> AFN -\(p)")
            
            }, success: { (task, result) -> Void in
    
                if let dict = result as? [String : AnyObject] {
                
                    if let array = dict["statuses"] as? [[String : AnyObject]]{
                        print("array  == \(array)")
                    }
                }
                
            }) { (task, error) -> Void in
                print(error)
        }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
