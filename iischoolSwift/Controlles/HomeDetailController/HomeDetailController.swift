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
    
    fileprivate lazy var backBtn : UIButton = {
        var backBtn = UIButton()
        backBtn.addTarget(self, action: #selector(HomeDetailController.backBtnDidClick), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "detail_icon_back_normal"), for: .normal)
        backBtn.setImage(UIImage(named: "detail_icon_back_pressed"), for: .highlighted)
        return backBtn
    }()
    
    fileprivate lazy var bottomView : XMHomeDetailBottomView =  {
        var bottomView = XMHomeDetailBottomView()
        return bottomView
    }()
    
    
    convenience init(homeModel : HomeModel){
        self.init()
        self.homeDetailModel = homeModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(centerView)
        self.view.addSubview(backBtn)
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        self.topImageView = centerView.headerImagView
        self.view.addSubview(toolBar)
    }

}

extension HomeDetailController : HomeDetailCenterViewDelegate{
    @objc func backBtnDidClick(){
        
    }
    func shareBtnDidClick(){
        
    }
}
