//
//  XMHomeDetailToolView.swift
//  iischoolSwift
//
//  Created by zhu on 2019/3/31.
//  Copyright © 2019年 hank. All rights reserved.
//

protocol XMHomeDetailToolViewDelegate{
    func homeDetailToolViewCollectBtnClick();
    func homeDetailToolViewShareBtnClick()
    func homeDetailToolViewDownloadBtnClick()
}

import UIKit

class XMHomeDetailToolView: UIView {
    @IBOutlet weak var xiaZhaiBtn: UIButton!
    @IBOutlet weak var fenXiang: UIButton!
    @IBOutlet weak var shouChang: UIButton!
    var delegate : XMHomeDetailToolViewDelegate?
    @IBAction func toolViewBtnClick(_ sender: Any) {
        print("\(sender)");
//        if(sender.tag == 1001){
//            self.delegate?.homeDetailToolViewCollectBtnClick()
//        }else if(sender.tag == 1002){
//            self.delegate?.homeDetailToolViewShareBtnClick()
//        }else if(sender.tag == 1003){
//            self.delegate?.homeDetailToolViewDownloadBtnClick()
//        }
    }
    
    class func toolView() ->XMHomeDetailToolView{
        return Bundle.main.loadNibNamed("XMHomeDetailToolView", owner: nil, options: nil)![0] as! XMHomeDetailToolView
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    convenience override init(frame: CGRect) {
        self.init()
        self.shouChang.imageView?.contentMode = .center
        self.fenXiang.imageView?.contentMode = .center
        self.xiaZhaiBtn.imageView?.contentMode = .center
    }
    
    
}
