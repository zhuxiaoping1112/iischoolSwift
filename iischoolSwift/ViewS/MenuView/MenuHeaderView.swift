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
        
        loginImageView
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------------------Getter and Setter-----------------
    fileprivate var loginImageView : UIImageView {
        let loginImageView :UIImageView = UIImageView(image: UIImage(named: "detail_portrait_default"))
        loginImageView.layer.cornerRadius = 50;
        loginImageView.contentMode = .scaleAspectFit
        return loginImageView
    }
    
    fileprivate var loginLable : UILabel {
        let loginLable :UILabel = UILabel()
        loginLable.text = "微博_hank"
        loginLable.font = UIConstant.FONT_16
        loginLable.textColor = UIColor.white
        return loginLable
    }
    
    
}


