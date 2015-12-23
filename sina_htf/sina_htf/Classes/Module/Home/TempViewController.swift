//
//  TempViewController.swift
//  sina_htf
//
//  Created by 赫腾飞 on 15/12/23.
//  Copyright © 2015年 hetefe. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "\(navigationController?.childViewControllers.count ?? 0)个控制器"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PUSH", style: .Plain, target: self, action: "push")
        
    }
    
    @objc private func push(){
    
        let temp = TempViewController()
        navigationController?.pushViewController(temp, animated: true)
    }

}
