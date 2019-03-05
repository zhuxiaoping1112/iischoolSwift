//
//  XMReflashBase.swift
//  iischoolSwift
//
//  Created by junke on 2019/3/4.
//  Copyright © 2019 hank. All rights reserved.
//

import UIKit

//控件的方向
enum XMRefreshDirection {
    case XMRefreshDirectionHorizontal
    case XMRefreshDirectionVertical
}

//控件刷新的状态
enum XMRefreshState {
    case  RefreshStateNormal                // 普通状态
    case  RefreshStatePulling               // 松开就可以进行刷新的状态
    case  RefreshStateRefreshing            // 正在刷新中的状态
    case  WillRefreshing
}

//控件的类型
enum XMRefreshViewType {
    case  RefreshViewTypeHeader             // 头部控件
    case  RefreshViewTypeFooter             // 尾部控件
}

class XMRefreshBase: UIView {
//MARK: ------------------定义属性-----------------
    typealias BeginRefreshingBlock = () -> Void
    //父控件
    var scrollView : UIScrollView!
    var scrollViewOriginalInset : UIEdgeInsets!
    // 箭头图片
    var arrowImage : UIImageView!
    // 刷新后回调
    var beginRefreshingCallback : BeginRefreshingBlock?
    //交给子类的去实现和调用
    var oldState : XMRefreshState?
    
    //默认水平方向
    var viewDirection : XMRefreshDirection! = XMRefreshDirection.XMRefreshDirectionHorizontal{
        willSet{
            self.viewDirection = newValue
        }
    }
    
    //当状态改变时 设置状态就会调用这个方法
    var State : XMRefreshState = XMRefreshState.RefreshStateNormal {
        willSet{
            self.State = newValue
        }
        
        didSet{
            switch self.State {
            case .RefreshStateNormal:
                self.arrowImage.stopAnimating()
                
            case .RefreshStatePulling:
                break
            case .RefreshStateRefreshing:
                self.arrowImage.startAnimating()
                if let _ = self.beginRefreshingCallback{
                    self.beginRefreshingCallback!()
                }
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.clear
        // 初始化箭头
        self.arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.arrowImage.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.arrowImage.image = UIImage(named: "loading_1")
        self.arrowImage.tag = 500
        
        var imgArray : Array<UIImage> = Array()
        // 添加图片
        for i in 0..<8 {
            let image : UIImage = UIImage(named: "loading_\(i+1)")!
            imgArray.append(image)
        }
        self.arrowImage.animationImages = imgArray
        self.arrowImage.animationDuration = 0.5
        self.arrowImage.animationRepeatCount = 999
        self.addSubview(arrowImage)
        
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal {
            self.autoresizingMask = .flexibleHeight
        } else {
            self.autoresizingMask = .flexibleWidth
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置剪头和菊花居中
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal{
            self.arrowImage.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height * 0.4)
        }else{
            self.arrowImage.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        }
    }
    
    override func draw(_ rect: CGRect) {
        superview?.draw(rect)
        if self.State == XMRefreshState.WillRefreshing {
            self.State = XMRefreshState.RefreshStateRefreshing
        }
    }
    
    //MARK: ------------------让子类重写-----------------
    override func willMove(toSuperview newSuperview: UIView?) {
        superview?.willMove(toSuperview: newSuperview)
        //移走旧的父控件
        if self.superview != nil {
            self.superview?.removeObserver(self, forKeyPath: XMRefreshContentOffset, context: nil)
        }
        //新的父控件,添加监听器
        if (newSuperview != nil){
            newSuperview?.addObserver(self, forKeyPath: XMRefreshContentOffset, options: NSKeyValueObservingOptions.new, context: nil)
        }
        var rect : CGRect = self.frame
        //设置宽度和
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal{
            // 设置宽度 位置
            if self.viewDirection == .XMRefreshDirectionHorizontal {
                rect.size.height = newSuperview!.frame.size.height
                rect.origin.y = 0
                self.frame = frame;
            } else {
                rect.size.width = newSuperview!.frame.size.width
                rect.origin.x = 0
                self.frame = frame;
            }
            
            //UIScrollView
            scrollView = newSuperview as? UIScrollView
            scrollViewOriginalInset = scrollView.contentInset;
        }
    }
    
    //判断是否是刷新
    func isReflashing() -> Bool{
        return XMRefreshState.RefreshStateRefreshing == self.State;
    }
    
    func beginRefreshing() {
        // self.State = RefreshState.Refreshing;
        if (self.window != nil) {
            self.State = XMRefreshState.RefreshStateRefreshing;
        } else {
            //不能调用set方法
            State = XMRefreshState.WillRefreshing;
            super.setNeedsDisplay()
        }
    }
    
    //结束刷新
    @objc func endRefreshing() {
        if self.State == .RefreshStateNormal {
            return
        }
        
        let delayInSeconds:Double = 0.3
        let popTime = DispatchTime.now() + delayInSeconds
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            self.State = XMRefreshState.RefreshStateNormal;
        }
    }
}
