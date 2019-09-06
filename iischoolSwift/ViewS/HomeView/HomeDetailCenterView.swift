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
        centerView.frame = self.bounds
        self.addSubview(centerView)
        headerImagView.frame = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 170)
        centerView.addSubview(headerImagView)
        appIconView.frame = CGRect(x: UIConstant.MARGIN_20, y:headerImagView.frame.maxY + UIConstant.MARGIN_20, width: 50, height: 50)
        centerView.addSubview(appIconView)
        let appTitleLableX = appIconView.frame.maxX + UIConstant.MARGIN_20
        let appTitleLableW = UIConstant.SCREEN_WIDTH - UIConstant.MARGIN_20 - appTitleLableX
        appTitleLabel.frame = CGRect(x: appTitleLableX, y: headerImagView.frame.maxY + UIConstant.MARGIN_20, width: appTitleLableW, height: 20)
        self.centerView.addSubview(appTitleLabel)
        
        //app详情
        appDetailLabel.frame = CGRect(x: appTitleLableX, y: appTitleLabel.frame.maxY, width: appTitleLableW, height: 20)
        self.centerView.addSubview(appDetailLabel)
        contentY = headerImagView.height+UIConstant.MARGIN_20+100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- private Methods
    private func setupOtherData() {
        // 计算文字高度，添加app描述文段
        let describeLabel = self.createPTitleLabel()
        self.centerView.addSubview(describeLabel)
        let descriSize = self.calculateTextHeight(text: model.digest!, label: describeLabel)
        describeLabel.frame = CGRect(x: UIConstant.MARGIN_10, y: contentY + UIConstant.MARGIN_10, width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: 2500)
        let newStr : String = String(format: "<head><style>img{width:%f !important;height:auto}</style></head>%@", arguments:[UIConstant.SCREEN_WIDTH,model.content])
        do {
            let attrStr = try NSAttributedString(data: newStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            describeLabel.attributedText = attrStr
        } catch {
            print("解析html出错 : \(error)")
            describeLabel.text = ""
        }
        contentY = describeLabel.frame.maxY + UIConstant.MARGIN_20
        // 添加http文段
//        let _ = XMLParserUtil(content: model.content!) { [unowned self](array) -> Void in
//            // 拿到解析完的数组后添加控件
//            for contentModel in array {
//
//                if contentModel.contentType == XMLContentType.XMLContentTypeH2 {
//                    // 标题
//                    self.contentY += UIConstant.MARGIN_10
//                    let h2TitlLabel = self.createH2TitleLabel()
//                    h2TitlLabel.text = contentModel.content
//                    h2TitlLabel.frame = CGRect(x: UIConstant.MARGIN_10, y: self.contentY, width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: 20)
//                    self.centerView.addSubview(h2TitlLabel)
//                    self.contentY += h2TitlLabel.height + UIConstant.MARGIN_10
//                } else if contentModel.contentType == XMLContentType.XMLContentTypeP {
//                    // 描述
//                    let pTitleLabel = self.createPTitleLabel()
//                    pTitleLabel.frame = CGRect(x: UIConstant.MARGIN_10, y: self.contentY, width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: 15)
//                    let pTitleSize = self.calculateTextHeight(text: contentModel.content, label: pTitleLabel)
//                    self.centerView.addSubview(pTitleLabel)
//                    self.contentY += pTitleSize.height + UIConstant.MARGIN_10
//                } else if contentModel.contentType == XMLContentType.XMLContentTypeA {
//                    // 点击下载
//                    let aTitleBtn = self.createATitleButton()
//                    aTitleBtn.frame = CGRect(x: UIConstant.MARGIN_10, y: self.contentY, width: 60, height: 20)
//                    self.centerView.addSubview(aTitleBtn)
//                    self.contentY += aTitleBtn.height + UIConstant.MARGIN_10
//                } else if contentModel.contentType == XMLContentType.XMLContentTypeImg {
//
//                    // 根据url 获取图片高度
//                    let size : CGSize = contentModel.content.getImageSizeWithURL()
//                    // 获取 _ 的位置
//                    let imgView : UIImageView = self.createImgView()
//                    imgView.frame = CGRect(x: UIConstant.MARGIN_10, y: self.contentY, width: size.width, height: size.height)
//                    imgView.center.x = UIConstant.SCREEN_WIDTH*0.5
//                    print("图片地址\(String(describing: contentModel.content))")
//                    let stringUrl : String = contentModel.content.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//                    imgView.nice_setImage(imageURL:URL(string: stringUrl))
//                    self.centerView.addSubview(imgView)
//                    self.contentY += size.height + UIConstant.MARGIN_10
//                }
//            }
//        }
        
        
        // 分享view
//        let shareView : XMHomeDetailShareView = XMHomeDetailShareView.shareView()
//        shareView.frame = CGRect(x: UIConstant.MARGIN_10, y: contentY, width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: shareView.height)
//        shareView.centerViewDidClickWithBlock { [unowned self]() -> Void in
//            self.centerDelegate?.shareBtnDidClick()
//        }
//        self.centerView.addSubview(shareView)
//        contentY += shareView.height
        
        // 评论view
        if model.comments.count != 0 {
            let commentLabel = self.createTitleViwe(title: "评论")
            commentLabel.frame = CGRect(x: UIConstant.MARGIN_10, y: contentY+2*UIConstant.MARGIN_10, width: 35, height: 20)
            contentY = commentLabel.frame.maxY+UIConstant.MARGIN_10;
            // 分割线
            let sepLine = self.createTitleSeparatLine()
            sepLine.frame = CGRect(x: commentLabel.frame.maxX, y: commentLabel.center.y, width:80, height: 0.5)
            
            // 添加评论
            for i in 0..<model.comments.count {
                let commentView = CommentCell(frame: CGRect(x: 0, y: contentY, width: UIConstant.SCREEN_WIDTH, height: 50))
                commentView.setData(model: self.model.comments[i])
                self.centerView.addSubview(commentView)
                contentY += commentView.height
            }
        }
        
        // 设置contentsize
        self.centerView.height = contentY
        self.contentSize = CGSize(width: 0, height: contentY)
    }
    
    private func calculateTextHeight (text: String, label:UILabel) ->CGSize{
        let  attributstring : NSMutableAttributedString = NSMutableAttributedString(string: text)
        let  paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        attributstring.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, text.count))
        
        let size = (text as String).boundingRect(with: CGSize(width: UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: CGFloat.greatestFiniteMagnitude),options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIConstant.FONT_16],context: nil).size
        label.attributedText = attributstring;
        return size
    }
    
    //Mark------------设置评论数--------------
    func setCommentData(comments :Array<CommentModel>){
        if comments.count != 0 {
            for i in 0..<comments.count{
                let commentView = CommentCell(frame: CGRect(x: 0, y: contentY, width: UIConstant.SCREEN_WIDTH, height: 50))
                commentView.setData(model: comments[i])
                self.centerView.addSubview(commentView)
                contentY += commentView.height
            }
        }
    }
    
    //MARK: - Public Method
    func updateHeaderView() {
        let HeaderHeight : CGFloat = headerImagView.height
        let HeaderCutAway: CGFloat = 170
        
        var headerRect = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: HeaderHeight)
        if self.contentOffset.y < 0 {
            headerRect.origin.y = self.contentOffset.y
            headerRect.size.height = -self.contentOffset.y + HeaderCutAway
            headerImagView.frame = headerRect
        }
    }

    
    
    //MARK: - getter or setter
    // 记录当前高度
    private var contentY: CGFloat = 0
    var centerDelegate: HomeDetailCenterViewDelegate?
    var model: HomeModel! {
        didSet {
            self.headerImagView.nice_setImage(imageURL: URL(string: model.cover_image!))
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
    lazy var headerImagView : UIImageView = {
        let headerImagView : UIImageView = UIImageView(image: UIImage(named: "home_logo_pressed"))
        headerImagView.contentMode = .scaleAspectFill
        return headerImagView
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
