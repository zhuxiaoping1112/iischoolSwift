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
    
    // scrollview
    fileprivate lazy var centerView: HomeDetailCenterView = {
        let centerView = HomeDetailCenterView()
        centerView.frame = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGHT)
        centerView.delegate = self as? UIScrollViewDelegate
        centerView.centerDelegate = self
        return centerView
    }()
    
    fileprivate lazy var toolBar : XMHomeDetailToolView = {
        var toolBar = XMHomeDetailToolView.toolView()
        toolBar.delegate = self as XMHomeDetailToolViewDelegate
        return toolBar
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

extension HomeDetailController : XMHomeDetailToolViewDelegate{
    func homeDetailToolViewCollectBtnClick() {
        print("收藏点击")
    }
    
    func homeDetailToolViewShareBtnClick() {
        print("分享点击")
    }
    
    func homeDetailToolViewDownloadBtnClick() {
        print("下载点击")
    }
    
    
}

extension HomeDetailController : HomeDetailCenterViewDelegate{
    @objc func backBtnDidClick(){
        
    }
    func shareBtnDidClick(){
        
    }
}
