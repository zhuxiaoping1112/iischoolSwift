//
//  MainViewController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIConstant.COLOR_APPNORMAL
        //初始化控制器
        intRootViewController()
        //添加覆盖层
        addCoverView()
        leftMenuShowAnimate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //Mark  --------------Getter and  Setter------------------
    fileprivate var menuControlller: MenuController!
    fileprivate var homeController: HomeController?
    fileprivate var findAppController: FindAppDetailController?
    fileprivate var currentController: UIViewController!
    fileprivate let menuMaxWidth: CGFloat = 0.8*UIConstant.SCREEN_WIDTH
    fileprivate weak var cover: UIWindow!
}


extension MainViewController{
    fileprivate func intRootViewController (){
        menuControlller = MenuController()
        menuControlller.view.frame = CGRect(x: 0, y: 0, width: menuMaxWidth, height: UIConstant.SCREEN_HEIGHT)
        homeController = HomeController()
        currentController = homeController
        currentController?.view.frame = self.view.bounds
        homeController?.delegate = self;
        
        addChild(menuControlller)
        addChild(currentController)
        
        view.addSubview(menuControlller.view)
        view.addSubview(currentController.view)
    }
    
    fileprivate func addCoverView(){
        let cover = UIWindow(frame: currentController.view.frame)
        let pan  = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.leftMenuDidDrag(pan:)))
        
        cover.backgroundColor = UIColor(red: 254/255.0, green: 254/255.0, blue: 245/255.0, alpha: 0.02)
        cover.addGestureRecognizer(pan)
        self.cover = cover
        currentController.view.addSubview(cover)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.leftMenuHiddenAnimate))
        cover.addGestureRecognizer(tap)
        self.view.bringSubviewToFront(cover)
        
    }
    
    @objc fileprivate func leftMenuDidDrag(pan : UIPanGestureRecognizer){
        let point = pan.translation(in: pan.view)
        if (pan.state == .cancelled || pan.state == .ended) {
            self.leftMenuHiddenAnimate()
        }else{
            currentController.view.x += point.x
            pan.setTranslation(CGPoint.zero, in: currentController.view)
            if currentController.view.x > menuMaxWidth {
                currentController.view.x = menuMaxWidth
                cover.isHidden = false
            }else if currentController.view.x <= 0 {
                currentController.view.x = 0
                cover.isHidden = true
            }
            
        }
    }
    
    @objc fileprivate func leftMenuShowAnimate(){
        UIView.animate(withDuration: 0.3) {
            self.currentController.view.x = self.menuMaxWidth
            self.menuControlller.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.cover.isHidden = false
        }
    }
    
    @objc fileprivate func leftMenuHiddenAnimate(){
        UIView.animate(withDuration: 0.3, animations: {
            self.currentController.view.x = 0
            self.cover.isHidden = true
        }) { (finish)->Void in
            self.menuControlller.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
    
}

extension MainViewController : HomeControllerDelegate{
    func menuBtnDidClick() {
        leftMenuShowAnimate()
    }
    
    func indexDidChange(withBackgroundColor: String) {
        view.backgroundColor = UIColor.hexString(hexString: withBackgroundColor)
        self.menuControlller.view.backgroundColor = UIColor.hexString(hexString: withBackgroundColor)
    }
}

//MARK: ------------------Getter and Setter-----------------
extension MainViewController :MenuControllerDelegate{
    func menuDidClick(withType : MenuItemType) {
        switch withType {
        case .dayily,.recommend,.article:
                guard currentController != homeController else{
                leftMenuHiddenAnimate()
                homeController?.apiTarget = withType.typeTarget()
                return
            }
            currentController.view.removeFromSuperview()
            currentController.removeFromParent()
            currentController = nil
            if homeController == nil{
                homeController = HomeController()
                homeController?.delegate = self
            }
            
            
        default:
         break
        }
    }
}
