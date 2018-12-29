//
//  MenuTableViewCell.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/29.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        //添加控件
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLable)
//        self.contentView.addSubview(dotView)
        
        iconView.snp.makeConstraints{
            
        }
        titleLable.snp.makeConstraints{
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    fileprivate var iconView : UIView {
        let iconView : UIView = UIView();
        iconView.layer.cornerRadius = 50
        return iconView
    }
    
    fileprivate var titleLable : UILabel{
        let titleLable : UILabel = UILabel()
        return titleLable
    }
}
