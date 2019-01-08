//
//  MenuTableViewCell.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/29.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        //添加控件
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLable)
        self.contentView.addSubview(dotView)
        
        iconView.snp.makeConstraints{make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(30)
        }
        titleLable.snp.makeConstraints { make in
            make.left.equalTo(self.iconView.snp.right).offset(15)
            make.top.bottom.right.equalTo(self.contentView)
        }
        
        dotView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 5, height: 5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    fileprivate var iconView : UIImageView {
        let iconView : UIImageView = UIImageView();
        iconView.layer.cornerRadius = 50
        return iconView
    }
    
    fileprivate var titleLable : UILabel{
        let titleLable : UILabel = UILabel()
        titleLable.text = "基础"
        return titleLable;
    }
    
    var dotView : UIView {
        let dotView : UIView = UIView()
        dotView.layer.cornerRadius = 10
        return dotView
    }
    var model : MenuTabModel!{
        didSet{
            self.iconView.image = model.image
            self.titleLable.text = model.title
        }
    }
    
    class func cell(withTableView tableView:UITableView) -> MenuTableViewCell {
        var cell = tableView.dequeueReusableCell() as MenuTableViewCell?
        if cell == nil{
            cell = MenuTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
}
