//
//  File.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/18.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit
@_exported import RxSwift
@_exported import SnapKit
@_exported import Moya


struct UIConstant {
    //屏幕高度
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height
    static let IPHONE6_WIDTH : CGFloat = 375
    static let IPHONE6_HEIGHT : CGFloat = 667
    static let IPHONE5_WIDTH : CGFloat = 320
    static let IPHONE5_HEIGHT : CGFloat = 568
    
    
    
    // 字体
    static let FONT_10 : UIFont = UIFont.systemFont(ofSize: 10)
    static let FONT_11 : UIFont = UIFont.systemFont(ofSize: 11)
    static let FONT_12 : UIFont = UIFont.systemFont(ofSize: 12)
    static let FONT_14 : UIFont = UIFont.systemFont(ofSize: 14)
    static let FONT_16 : UIFont = UIFont.systemFont(ofSize: 16)
    static let FONT_18 : UIFont = UIFont.systemFont(ofSize: 18)
    static let FONT_20 : UIFont = UIFont.systemFont(ofSize: 20)
    static let FONT_22 : UIFont = UIFont.systemFont(ofSize: 22)
    
    // 默认背景色
    static let COLOR_APPNORMAL : UIColor = UIColor(red: 54/255.0, green: 142/255.0, blue: 198/255.0, alpha: 1)
    static let COLOR_BORDER : UIColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
    
    // 间距
    static let MARGIN_5 : CGFloat = 5
    static let MARGIN_10 : CGFloat = 10
    static let MARGIN_15 : CGFloat = 15
    static let MARGIN_20 : CGFloat = 20
    
    static let mainStory :UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    //判断是否是ipad
    static let isPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    //判断iPhone4系列
    static let kiPhone4 :Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ? (CGSize(width:640,height:960).equalTo(UIScreen.main.currentMode!.size)) && !isPad : false)
    //判断iPhone5系列
    static let kiPhone5 : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 640, height: 1136).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iPhone6系列
    static let kiPhone6 : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 750, height: 1334).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iphone6+系列
    static let kiPhone6Plus : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 1242, height: 2208).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iPhoneX
    static let IS_IPHONE_X : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iPHoneXr
    static let IS_IPHONE_Xr : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 828, height: 1792).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iPhoneXs
    static let IS_IPHONE_Xs : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    //判断iPhoneXs Max
    static let IS_IPHONE_Xs_Max : Bool = ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode))) ?(CGSize(width: 1242, height: 2688).equalTo(UIScreen.main.currentMode!.size)) && !isPad :false)
    
    //iPhoneX系列
    static let Height_StatusBar : CGFloat = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 44.0 : 20.0)
    static let Height_NavBar : CGFloat = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 88.0 : 64.0)
    static let Height_TabBar : CGFloat = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 83.0 : 49.0)
}
