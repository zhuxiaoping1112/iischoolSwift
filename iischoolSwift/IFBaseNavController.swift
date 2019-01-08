//
//  IFBaseNavController.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/15.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

class IFBaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)){
            interactivePopGestureRecognizer?.delegate = self;
            delegate = self;
        }
        self.view.backgroundColor = UIColor.clear
        self.isNavigationBarHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension IFBaseNavController:UIGestureRecognizerDelegate{
    override func popViewController(animated: Bool) -> UIViewController? {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated{
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated{
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
}


extension IFBaseNavController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)){
            interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
