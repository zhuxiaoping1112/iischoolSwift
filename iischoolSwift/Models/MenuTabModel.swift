//
//  MenuModel.swift
//  iischoolSwift
//
//  Created by junke on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

import Foundation
import UIKit

struct MenuTabModel {
    let image : UIImage
    let title : String
}

let MenuTabItems = [
    MenuTabModel(image: UIImage(named: "sidebar_icon_apps_normal")!, title: "每日最美"),
    MenuTabModel(image: UIImage(named: "sidebar_icon_box_normal")!, title: "限免推荐"),
    MenuTabModel(image: UIImage(named: "sidebar_icon_discover_normal")!, title: "发现应用"),
    MenuTabModel(image: UIImage(named: "sidebar_icon_article_normal")!, title: "文章专栏"),
    MenuTabModel(image: UIImage(named: "sidebar_icon_beauty_normal")!, title: "美我一下"),
    MenuTabModel(image: UIImage(named: "sidebar_icon_fav_normal")!, title: "我的收藏")
]

