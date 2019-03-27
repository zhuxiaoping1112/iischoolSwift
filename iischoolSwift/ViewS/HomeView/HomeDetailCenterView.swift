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
    
    // 顶部图片
    lazy var headerImgView : UIImageView = {
        let headerImgView : UIImageView = UIImageView(image: UIImage(named: "home_logo_pressed"))
        headerImgView.contentMode = .scaleAspectFill
        return headerImgView
    }()
    
    // appIcon
    private lazy var appIconView : UIImageView = {
        let appIconView : UIImageView = UIImageView(image: UIImage(named: "ic_launcher"))
        //        appIconView.contentMode = .ScaleAspectFit
        appIconView.layer.cornerRadius = UIConstant.MARGIN_10
        appIconView.layer.masksToBounds = true
        return appIconView
    }()
    
    // app大标题
    private lazy var appTitleLabel : UILabel = {
        let appTitleLabel : UILabel = UILabel()
        appTitleLabel.font = UIConstant.FONT_20
        appTitleLabel.textColor = UIColor.black
        return appTitleLabel
    }()
    
    // app 详情
    private lazy var appDetailLabel : UILabel = {
        let appDetailLabel : UILabel = UILabel()
        appDetailLabel.font = UIConstant.FONT_14
        appDetailLabel.textColor = UIColor.darkGray
        return appDetailLabel
    }()
    
    private func createTitleViwe(title : String) -> UILabel {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = title
        label.textColor = UIColor.black
        self.centerView.addSubview(label)
        return label
    }
    private func createTitleSeparatLine() -> UIView {
        let line : UIView = UIView()
        line.backgroundColor = UIColor.lightGray
        self.centerView.addSubview(line)
        return line
    }
    // 标题(h2)
    private func createH2TitleLabel() -> UILabel {
        let h2TitleLabel = UILabel()
        h2TitleLabel.textColor = UIColor.black
        h2TitleLabel.font = UIConstant.FONT_16
        return h2TitleLabel
    }
    
    // 描述(p)
    private func createPTitleLabel() -> UILabel {
        let contentLabel = UILabel()
        contentLabel.font = UIConstant.FONT_16
        contentLabel.textColor = UIColor.darkGray
        contentLabel.numberOfLines = 0
        return contentLabel
    }
    
    // 图片(Img)
    private func createImgView() -> UIImageView {
        let imgView : UIImageView = UIImageView()
        imgView.layer.cornerRadius = 3
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.borderWidth = 0.5
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    // 下载(a)
    private func createATitleButton() -> UIButton {
        let btn : UIButton = UIButton()
        btn.titleLabel?.textAlignment = NSTextAlignment.left
        btn.titleLabel?.font = UIConstant.FONT_14
        btn.setTitle("点击下载", for: .normal)
        btn.setTitleColor(UIConstant.COLOR_APPNORMAL, for: .normal)
        return btn
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
