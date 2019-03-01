//
//  HomeDetailController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class HomeDetailController: UIViewController {
    var shadowView : UIView?
//    var shareView : ShareView?
    
    fileprivate var homeDetailModel : HomeModel!
    //评论
    fileprivate var page : Int = 1
    //顶部图片
    weak var topImageView : UIImageView!
    
    fileprivate lazy var  centerView : HomeDetailCenterView = {
        var centerView = HomeDetailCenterView()
        
        return centerView
    }()
    
    convenience init(homeModel : HomeModel){
        self.init()
        self.homeDetailModel = homeModel
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

}
