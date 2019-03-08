//
//  HomeDetailCenterView.swift
//  iischoolSwift
//
//  Created by junke on 2019/3/1.
//  Copyright © 2019 hank. All rights reserved.
//

import UIKit

protocol HomeDetailCenterViewDelegate {
    func shareBtnDidClick()
    func backBtnDidClick()
}

class HomeDetailCenterView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- private Methods
    private func setupOtherData() {
        
    }
    
    //计算文字高度
    func calculateTextHeight(text : String , lable : UILabel) -> CGSize {
        let attribute : NSMutableAttributedString = NSMutableAttributedString(string: text)
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        attribute.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0 , text.count));
        let size = (text as NSString).boundingRect(with: CGSize(width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIConstant.FONT_16], context: nil).size
        return size
    }
    
    //MARK: - Public Method
    func updateHeaderView() {
        let HeaderHeight : CGFloat = headerImgView.height
        let HeaderCutAway: CGFloat = 170
        
        var headerRect = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: HeaderHeight)
        if self.contentOffset.y < 0 {
            headerRect.origin.y = self.contentOffset.y
            headerRect.size.height = -self.contentOffset.y + HeaderCutAway
            headerImgView.frame = headerRect
        }
    }

    
    
    //MARK: - getter or setter
    // 记录当前高度
    private var contentY: CGFloat = 0

    var centerDelegate: HomeDetailCenterViewDelegate?
    var model: HomeModel! {
        didSet {
            self.headerImgView.nice_setImage(imageURL: URL(string: model.cover_image!))
            // 图标
            self.appIconView.nice_setImage(imageURL: URL(string: model.icon_image!), placeholderImage: UIImage(named: "ic_launcher")!)
            self.appTitleLabel.text = model.title!
            self.appDetailLabel.text = model.sub_title!
            // 添加其他控件
            
            self.setupOtherData()
        }
    }

    // 内容
    private lazy var centerView : UIView = {
        let centerView : UIView = UIView()
        return centerView
    }()

    
    lazy var headerImgView : UIImageView  = {
        let headerImgView : UIImageView = UIImageView(image: UIImage(named: "home_logo_pressed"))
        headerImgView.contentMode = .scaleAspectFill
        return headerImgView
    }()
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
