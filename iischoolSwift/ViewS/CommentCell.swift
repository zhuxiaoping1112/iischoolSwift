//
//  CommentCell.swift
//  iischoolSwift
//
//  Created by zhu on 2019/4/2.
//  Copyright © 2019年 hank. All rights reserved.
//

import UIKit

class CommentCell: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 头像
        userImgView.frame = CGRect(x: UIConstant.MARGIN_10, y: 0, width: 30, height: 30)
        self.addSubview(userImgView)
        // 名字
        userNameLabel.frame = CGRect(x: userImgView.frame.maxX + UIConstant.MARGIN_10, y: 0, width: 150, height: 15)
        self.addSubview(userNameLabel)
        // 详情
        userDetailLabel.frame = CGRect(x: userNameLabel.x, y: userNameLabel.frame.maxY, width: 120, height: 15)
        self.addSubview(userDetailLabel)
        // 时间
        timeLabel.frame = CGRect(x: UIConstant.SCREEN_WIDTH-120-UIConstant.MARGIN_10, y: 0, width: 120, height: 15)
        self.addSubview(timeLabel)
        // 评论背景
        commentBg.frame = CGRect(x: UIConstant.MARGIN_10, y: userImgView.frame.maxY+UIConstant.MARGIN_5, width:UIConstant.SCREEN_WIDTH-2*UIConstant.MARGIN_10, height: 20)
        self.addSubview(commentBg)
        // 评论
        commentLabel.frame = CGRect(x: UIConstant.MARGIN_10, y: 15, width: commentBg.width-2*UIConstant.MARGIN_10, height: 20)
        commentBg.addSubview(commentLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(model: CommentModel) {
        self.userImgView.nice_setImage(imageURL: URL(string: model.author_avatar_url), placeholderImage: UIImage(named: "detail_portrait_default"))
        self.userNameLabel.text = model.author_name
        // 3.设置详情
        self.userDetailLabel.text = model.author_career!
        // 4.时间
        self.timeLabel.text = model.updated_at!
        // 5.评论内容
        let attributStr : NSMutableAttributedString = NSMutableAttributedString(string: model.content!)
        attributStr.setAttributes([NSAttributedString.Key.font: UIConstant.FONT_12], range: NSMakeRange(0, model.content!.count))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5.0
        attributStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, model.content!.count))
        commentLabel.attributedText = attributStr
        let size = (model.content as NSString).boundingRect(with: CGSize(width: commentBg.width-2*UIConstant.MARGIN_10, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIConstant.FONT_10], context: nil).size
        commentLabel.size = size
        // 设置frame
        self.commentBg.height = commentLabel.frame.maxY+UIConstant.MARGIN_10
        self.height = commentBg.frame.maxY+UIConstant.MARGIN_10
    }
    
    //头像
    private lazy var userImgView : UIImageView = {
        let userImgView : UIImageView = UIImageView()
        userImgView.layer.cornerRadius = 15
        userImgView.layer.borderColor = UIColor.lightGray.cgColor
        userImgView.layer.borderWidth = 1
        userImgView.layer.masksToBounds = true
        return userImgView
    }()
    
    // 名字
    private lazy var userNameLabel : UILabel = {
        let userNameLabel : UILabel = UILabel()
        userNameLabel.font = UIConstant.FONT_12
        userNameLabel.textColor = UIColor.black
        return userNameLabel
    }()
    
    // 详情
    private lazy var userDetailLabel : UILabel = {
        let userDetailLabel : UILabel = UILabel()
        userDetailLabel.font = UIConstant.FONT_10
        userDetailLabel.textColor = UIColor.lightGray
        return userDetailLabel
    }()
    
    // 时间
    private lazy var timeLabel : UILabel = {
        let timeLabel : UILabel = UILabel()
        timeLabel.textColor = UIColor.lightGray
        timeLabel.font = UIConstant.FONT_10
        timeLabel.textAlignment = NSTextAlignment.right
        return timeLabel
    }()
    
    private lazy var  commentBg : UIImageView = {
        var commentBg : UIImageView = UIImageView()
        let bgImg : UIImage = UIImage(named: "detail_comment_bg")!
        let stretchWidth = bgImg.size.width*0.8
        let stretchHeight = bgImg.size.height*0.4
        commentBg.image = bgImg.resizableImage(withCapInsets: UIEdgeInsets(top: stretchHeight, left: stretchWidth, bottom: stretchHeight, right: bgImg.size.width*0.1), resizingMode: UIImage.ResizingMode.stretch)
        return commentBg
    }()

    // 评论了内容
    private lazy var commentLabel: UILabel = {
        var commentLabel = UILabel()
        commentLabel.font = UIConstant.FONT_10
        commentLabel.textColor = UIColor.darkGray
        commentLabel.numberOfLines = 0
        return commentLabel
    }()
}
