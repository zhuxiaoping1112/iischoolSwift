//
//  MenuHeaderView.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/20.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loginImageView)
        addSubview(loginLable)
        
        loginImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.left.equalTo(self).offset(25)
            make.top.equalTo(self).offset(30)
        }
        
        loginLable.snp.makeConstraints { (make) in
            make.left.equalTo(loginImageView.snp.right).offset(15)
            make.centerY.equalTo(loginImageView.snp.centerY)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------------------Getter and Setter-----------------
    fileprivate  lazy var loginImageView : UIImageView = {
        let loginImageView :UIImageView = UIImageView(image: UIImage(named: "detail_portrait_default"))
        loginImageView.layer.cornerRadius = 25
        loginImageView.clipsToBounds = true
        loginImageView.contentMode = .scaleAspectFit
        return loginImageView
    }()
    
    fileprivate lazy var loginLable : UILabel = {
        let loginLable :UILabel = UILabel()
        loginLable.text = "微博_hank"
        loginLable.font = UIConstant.FONT_16
        loginLable.textColor = UIColor.white
        return loginLable
    }()
    
    
}


