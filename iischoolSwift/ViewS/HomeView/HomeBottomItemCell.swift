//
//  HomeBottomItemCellCollectionViewCell.swift
//  iischoolSwift
//
//  Created by junke on 2019/2/28.
//  Copyright © 2019 hank. All rights reserved.
//

import UIKit

class HomeBottomItemCell: UICollectionViewCell , Reusable{
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has been in import")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        addSubview(iconView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(2)
            make.right.equalTo(self).inset(2)
            make.width.equalTo(iconView.snp.height).multipliedBy(1)
        }
    }
    
    var iconUrl : String! {
        didSet{
            self.iconView.nice_setImage(imageURL: URL(string: iconUrl), imageCornerRadius: 8)
        }
    }
    
    fileprivate lazy var iconView :UIImageView = {
        var iconView = UIImageView()
        return iconView
    }()
}
