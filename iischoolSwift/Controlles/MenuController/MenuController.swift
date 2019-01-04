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
    
}

class MenuController: UIViewController {
    fileprivate  var mainTableView : UITableView {
        let mainTableView :UITableView = UITableView()
        mainTableView.backgroundColor = UIColor.clear
        mainTableView.separatorStyle = .none
        let header = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 120))
        mainTableView.tableHeaderView = header
        mainTableView.rowHeight = 50
        mainTableView.sectionHeaderHeight = 120
//        mainTableView.delegate = self
//        mainTableView.dataSource = self
        return mainTableView
    }
    
    fileprivate var footerView : MenuFooterView {
        let footerView = MenuFooterView()
        footerView.delete(self)
        return footerView
    }
    
    fileprivate var headerView : MenuHeaderView{
        let headerView :MenuHeaderView = MenuHeaderView()
        return headerView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIConstant.COLOR_APPNORMAL
        view.addSubview(mainTableView)
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

extension MainViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = MenuTableViewCell.cell(withtable)

        
        return menuCell
    }
    
    
}
