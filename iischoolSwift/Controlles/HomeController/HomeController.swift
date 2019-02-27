//
//  HomeController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

protocol HomeControllerDelegate {
    //点击菜单按钮
    func menuBtnDidClick()
    
    //index 改变时,让main去改变背景颜色
    func indexDidChange(withBackgroundColor:String)
}

class HomeController: UIViewController,ControllerReusable {
    convenience init(apiTarget:APIConstant) {
        self.init()
        self.apiTarget = apiTarget
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIConstant.COLOR_APPNORMAL
        view.addSubview(headerView)
        view.addSubview(collectionView)
    //MARK: ------------------待完成-----------------
//        view.addSubview(bottomCollectionView)
        
    }
    var progressView: UIImageView!
    /// 代理
    var delegate: HomeControllerDelegate?
    /// 列表的数据源
    fileprivate var homeModelArray = Array<HomeModel>()
    /// 页数
    fileprivate var page : Int = 1
    /// 上一个index
    fileprivate var lastIndex: IndexPath?
    /// 当前index
    fileprivate var currentIndex: IndexPath! = IndexPath(row: 0, section: 0) {
        didSet {
            guard self.homeModelArray.count > 0 else {
                return
            }
            // 获取模型
            let model: HomeModel = homeModelArray[currentIndex.row]
            // 设置header模型
            self.headerView.homeModel = model
            // 设置背景的动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.backgroundColor = UIColor.hexString(hexString:  model.recommanded_background_color)
            })
            self.delegate?.indexDidChange(withBackgroundColor: model.recommanded_background_color)
        }
    }
    
    
    /// 顶部view
    fileprivate lazy var headerView: HomeHeaderView = {
        var headerView = HomeHeaderView()
        headerView.delegate = self
        return headerView
    }()
    
    ///中间内容模块
    fileprivate lazy var collectionView :UICollectionView = {
        var layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_5, height: UIConstant.SCREEN_HEIGHT*420/UIConstant.IPHONE5_HEIGHT)
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 5)
        
        var collectionView = UICollectionView.init(frame: CGRect(x: 0, y: UIConstant.MARGIN_20+UIConstant.SCREEN_HEIGHT*50/UIConstant.IPHONE5_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGHT*420/UIConstant.IPHONE5_HEIGHT), collectionViewLayout: layout)
        collectionView.delegate = (self as! UICollectionViewDelegate)
        collectionView.dataSource = (self as! UICollectionViewDataSource)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.registerClass(HomeCenterItemCell.self)
        collectionView.tag = 100
        return collectionView
    }()
    
    
    
    
    var apiTarget : APIConstant! = .daily(1){
        didSet{
            self.page = 1
          
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
//MARK: ------------------HeaderViewDelegate-----------------
extension HomeController :HeaderViewDelegate{
    func headerViewMoveToFirstBtnDidClick() {
        
    }
    
    func headerViewMenuBtnDidClick() {
        
    }
    
    
}
