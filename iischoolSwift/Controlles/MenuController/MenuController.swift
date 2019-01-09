//
//  MenuController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit
import SafariServices


enum MenuItemType{
    // 每日最美
    case dayily
    // 限免推荐
    case recommend
    // 发现应用
    case findApp
    // 文章专栏
    case article
    // 美我一下
    case appStoreComment
    // 我的收藏
    case collect
    
    func typeTarget() -> APIConstant {
        switch self {
        case .dayily:
            return .daily(1)
        case .recommend:
            return .recommend(1)
        case .findApp:
            return .popular(1)
        case .article:
            return .article
        default:
            return .daily(1)
        }
    }
}

protocol MenuControllerDelegate{
    func menuDidClick(withType: MenuItemType)
}

class MenuController: UIViewController {
    fileprivate lazy var mainTableView : UITableView = {
        let mainTableView :UITableView = UITableView()
        mainTableView.backgroundColor = UIColor.clear
        mainTableView.separatorStyle = .none
        let header = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 120))
        mainTableView.tableHeaderView = header
        mainTableView.rowHeight = 50
        mainTableView.sectionHeaderHeight = 120
        mainTableView.delegate = self
        mainTableView.dataSource = self
        return mainTableView
    }()
    
    fileprivate lazy var footerView : MenuFooterView = {
        let footerView = MenuFooterView()
//        footerView.delete(self)
        return footerView
    }()

    
    var delegate : MenuControllerDelegate?
    fileprivate var type: MenuItemType! = .dayily
    public var lastSelectDotView : UIView!
    fileprivate var selectIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIConstant.COLOR_APPNORMAL
        view.addSubview(mainTableView)
        view.addSubview(footerView)
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupLayout() -> Void {
        mainTableView.snp.makeConstraints{(make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(UIConstant.SCREEN_HEIGH - 40 - UIConstant.Height_TabBar)
        }
        footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        }
    }
}

extension MenuController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuTabItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = MenuTableViewCell.cell(withTableView: tableView)
        menuCell.model = MenuTabItems[indexPath.row]
        if indexPath.row == 0 {
            menuCell.dotView.isHidden = false
            lastSelectDotView = menuCell.dotView
        }
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectIndex != indexPath.row else {
            return
        }
        switch indexPath.row {
        case 0:
            //每日最美
            type = MenuItemType.dayily
        case 1:
            // 限免推荐
            type = MenuItemType.recommend
        case 2:
            // 发现应用
            type = MenuItemType.findApp
        case 3:
            //文章专栏
            type = MenuItemType.article
        case 4:
            // 美我一下
            type = MenuItemType.appStoreComment
            if #available(iOS 10.0, *){
                UIApplication.shared.open(APIConstant.appStoreComment.baseURL, options: [:], completionHandler: nil)
            }else{
                UIApplication.shared.openURL(APIConstant.appStoreComment.baseURL)
            }
        case 5:
            // 我的收藏
            type = MenuItemType.collect
        default:
            break
        }
        if type == MenuItemType.appStoreComment || type == MenuItemType.collect {
            return
        }
        delegate?.menuDidClick(withType: type)
        selectIndex = indexPath.row
        lastSelectDotView.isHidden = true
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        lastSelectDotView = cell.dotView
        cell.dotView.isHidden = false
    }

}
