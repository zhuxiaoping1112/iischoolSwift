//
//  XMRefreshHeaderView.swift
//  iischoolSwift
//
//  Created by junke on 2019/3/5.
//  Copyright © 2019 hank. All rights reserved.
//

import UIKit

class XMRefreshHeaderView: XMRefreshBase {
    override var State : XMRefreshState {
        willSet{
            oldState = State
        }
        didSet{
            switch self.State {
            case .RefreshStateNormal:
                if oldState == XMRefreshState.RefreshStateRefreshing{
                    UIView.animate(withDuration: XMRefreshSlowAnimationDuration) {
                        self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                    }
                    self.scrollView.setContentOffset(CGPoint.zero, animated: true)
                }else{
                    UIView.animate(withDuration: XMRefreshSlowAnimationDuration) {
                        self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
                    }
                }
                self.scrollView.isScrollEnabled = true
                //释放刷新状态
            case .RefreshStatePulling:
                UIView.animate(withDuration: XMRefreshSlowAnimationDuration, animations: {
                    self.arrowImage.transform = CGAffineTransform.identity
                })
            case .RefreshStateRefreshing:
                if XMRefreshDirection.XMRefreshDirectionHorizontal == self.viewDirection{
                    self.scrollView.contentOffset = CGPoint(x: -self.width, y: 0)
                }else{
                    self.scrollView.contentOffset = CGPoint(x: 0, y: -self.height)
                }
            default:
            break
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal {
            self.frame = CGRect(x: -XMRefreshViewHeight, y: 0, width: XMRefreshViewHeight, height: UIConstant.SCREEN_HEIGHT)
        } else {
            self.frame = CGRect(x: 0, y: -XMRefreshViewHeight, width: UIConstant.SCREEN_WIDTH, height: XMRefreshViewHeight)
        }
    }
    
    //创建view的静态方法
    class func headerView() -> XMRefreshHeaderView {
        return XMRefreshHeaderView(frame: CGRect(x: -XMRefreshViewHeight, y: 0, width: XMRefreshViewHeight, height: UIConstant.SCREEN_HEIGHT))
    }
    
    //设置header fram
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal {
            self.x = -XMRefreshViewHeight
        } else {
            self.y = -XMRefreshViewHeight
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard !self.isHidden else{
            return
        }
        
        guard self.State != XMRefreshState.RefreshStateRefreshing else{
            return
        }
        
        if self.viewDirection == XMRefreshDirection.XMRefreshDirectionHorizontal  {
            let currentOffsetY : CGFloat = self.scrollView.contentOffset.x
            let happenOffsetY : CGFloat = -self.scrollViewOriginalInset.left
            
            if (currentOffsetY >= happenOffsetY) {
                return
            }
            
            // 根据scrollview 滑动的位置设置当前状态
            if self.scrollView.isDragging {
                let normal2pullingOffsetY : CGFloat = happenOffsetY - XMRefreshViewHeight
                if self.State == XMRefreshState.RefreshStateNormal && currentOffsetY < normal2pullingOffsetY {
                    self.State = XMRefreshState.RefreshStatePulling
                } else if self.State == XMRefreshState.RefreshStatePulling && currentOffsetY >= normal2pullingOffsetY{
                    self.State = XMRefreshState.RefreshStateNormal
                }
                
            } else if self.State == XMRefreshState.RefreshStatePulling {
                self.State = XMRefreshState.RefreshStateRefreshing
            }
        } else {
            let currentOffsetY : CGFloat = self.scrollView.contentOffset.y
            let happenOffsetY : CGFloat = -self.scrollViewOriginalInset.top
            
            if (currentOffsetY >= happenOffsetY) {
                return
            }
            // 根据scrollview 滑动的位置设置当前状态
            if self.scrollView.isDragging {
                let normal2pullingOffsetY : CGFloat = happenOffsetY - XMRefreshViewHeight
                if self.State == XMRefreshState.RefreshStateNormal && currentOffsetY < normal2pullingOffsetY {
                    self.State = XMRefreshState.RefreshStatePulling
                } else if self.State == XMRefreshState.RefreshStatePulling && currentOffsetY >= normal2pullingOffsetY{
                    self.State = XMRefreshState.RefreshStateNormal
                }
                
            } else if self.State == XMRefreshState.RefreshStatePulling {
                self.State = XMRefreshState.RefreshStateRefreshing
            }
        }
    }
    
    deinit {
        self.endRefreshing()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
