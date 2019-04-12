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
    fileprivate var model : HomeModel!

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
        toolBar.frame = CGRect(x: 0, y: 245, width: UIConstant.SCREEN_WIDTH, height: 30)
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
    
    
    convenience init(model : HomeModel){
        self.init()
        self.model = model
        centerView.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.topImageView = centerView.headerImagView
        self.view.addSubview(centerView)
        self.view.addSubview(toolBar)
        self.view.addSubview(backBtn)
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        self.setUpLayout()
        self.getCommentData()
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
        self.navigationController?.popViewController(animated: true)
    }
    func shareBtnDidClick(){
        
    }
}

extension HomeDetailController{
    fileprivate func getCommentData(){
        print("\(self.model.id!)")
        niceProvider.request(APIConstant.comment(self.model.id, self.page), completion: { result in
            switch result{
                case let .success(response):
                do{
                   let json = try response.mapJSON() as! NSDictionary
                    guard let content = json["data"] as? NSDictionary else{
                        return
                    }
                    guard let contentArray = content["comments"] as? Array<NSDictionary> else{
                        return
                    }
                    if contentArray.count != 0 {
                        var commentArray : Array<CommentModel> = Array()
                        for dict in contentArray{
                            let model = CommentModel(dict: dict)
                            self.model.comments.append(model)
                            commentArray.append(model)
                        }
                        self.page += 1
                        self.centerView.setCommentData(comments: commentArray)
                    }
                }catch{
                    print("数据异常")
                }
                    default:
                    break
            }
        })
    }
    
    fileprivate func setUpLayout(){
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(10)
            make.top.equalTo(self.view.snp.top).offset(40)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        }
    }
}


