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
        view.addSubview(self.headerView)
        view.addSubview(self.collectionView)
        view.addSubview(self.bottomCollectionView)
        
        getData(target: self.apiTarget)
        
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(UIConstant.MARGIN_20)
            make.height.equalTo(UIConstant.SCREEN_HEIGHT*50/UIConstant.IPHONE5_HEIGHT)
        }
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.registerClass(HomeCenterItemCell.self)
        collectionView.tag = 100
        return collectionView
    }()
    
    //底部音炫
    fileprivate lazy var bottomCollectionView : HomeBottomCollectionView = {
        var bottomCollectionView = HomeBottomCollectionView(frame: CGRect(x: 0, y: UIConstant.SCREEN_HEIGHT-60-UIConstant.SafeAreaBottomHeight, width: UIConstant.SCREEN_WIDTH, height: 60), collectionViewLayout: HomeBottomFlowLayout())
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        return bottomCollectionView
    }()
    
    
    var apiTarget : APIConstant! = .daily(1){
        didSet{
            self.page = 1
            self.collectionView.isHidden = true
            self.bottomCollectionView.isHidden = true
            self.showProgress()
            getData(target: apiTarget)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
//MARK: ------------------HeaderViewDelegate-----------------
extension HomeController :HeaderViewDelegate{
    func headerViewMoveToFirstBtnDidClick() {
        self.collectionView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func headerViewMenuBtnDidClick() {
        self.delegate?.menuBtnDidClick()
    }
}

//MARK: ------------------bottomCollectionViewDelegate-----------------
extension HomeController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeModelArray.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let model = homeModelArray[indexPath.row]
        if collectionView.tag == 100 {
            let cell = cell as! HomeCenterItemCell
            cell.model = model
        } else {
            let cell = cell as! HomeBottomItemCell
            cell.iconUrl = model.icon_image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as HomeCenterItemCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as HomeBottomItemCell
            cell.y = 50
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        // 获取cell中的图片 和 rect 用于做转场动画
        //        let cell = collectionView.cellForItem(at: indexPath) as! HomeCenterItemCell
        //        self.curImgView = cell.coverImageView
        //        // 计算collection点击的item在屏幕中的位置
        //        let rectInCollectionView = (collectionView.layoutAttributesForItem(at: indexPath)?.frame)!
        //        let rectInSuperView = collectionView.convert(rectInCollectionView, to: collectionView.superview)
        //        self.rectInView = CGRect(x: rectInSuperView.origin.x+cell.coverImageView.x, y: rectInSuperView.origin.y+cell.coverImageView.y, width: rectInSuperView.width, height: cell.coverImageView.height)
        // 获取模型
        let model = homeModelArray[indexPath.row]
        let detailController = HomeDetailController(model: model)
//        let detailController = HomeDetailController()
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

//MARK: --------------------------- Private Methods --------------------------

extension HomeController {
   fileprivate func getData(target: APIConstant) {
    NiceServices.shareInstance.getHomeData(target: target) {
        [unowned self](modelArray) in
            switch target{
            case.article:
//                self.collectionView.setHeaderHidden(hidden: true)
                
                break
            default:
                break
            }
        if self.page == 1{
            self.homeModelArray.removeAll()
            self.hiddenProgress()
        }
        for mode in modelArray{
            self.homeModelArray.append(mode)
        }
        self.collectionView.reloadData()
        self.bottomCollectionView.reloadData()
        if self.page == 1{
            self.lastIndex = nil
            self.collectionView.isHidden = false
            self.bottomCollectionView.isHidden = false
            self.collectionView.setContentOffset(CGPoint.zero, animated: false)
            self.bottomCollectionView.setContentOffset(CGPoint.zero, animated: false)
            self.currentIndex = IndexPath(row: 0, section: 0)
//            self.bottomCollectionView(inde)
        }else{
            self.currentIndex = IndexPath(row: self.homeModelArray.count - 10, section: 0)
            
        }
    
        }
    }
}
