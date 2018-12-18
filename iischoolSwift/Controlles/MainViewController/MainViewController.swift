//
//  MainViewController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIConstant.COLOR_APPNORMAL
        //初始化控制器
        intRootViewController()
        //添加覆盖层
        addCoverView()
        
        leftMenuShowAnimate()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MainViewController{
    fileprivate func intRootViewController (){
    
    }
    
    fileprivate func addCoverView(){
        
    }
    
    fileprivate func leftMenuShowAnimate(){
        
    }
}
