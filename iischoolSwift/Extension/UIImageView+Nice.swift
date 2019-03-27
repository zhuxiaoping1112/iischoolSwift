//
//  UIImageView+Nice.swift
//  iischoolSwift
//
//  Created by junke on 2019/2/28.
//  Copyright © 2019 hank. All rights reserved.
//

import Foundation
import UIKit
import YYWebImage

extension UIImageView{
    public func nice_setImage(imageURL: URL!){
        self.nice_setImage(imageURL: imageURL ,placeholderImage:UIImage(named: "home_logo_pressed"))
    }
    
    public func nice_setImage(imageURL: URL!,placeholderImage : UIImage!){
        self.yy_setImage(with: imageURL, placeholder: placeholderImage, options: [.setImageWithFadeAnimation,.progressiveBlur], completion: nil)
    }
    
    public func nice_setImage(imageURL: URL!, imageCornerRadius: CGFloat) {
        self.yy_setImage(with: imageURL, placeholder: UIImage(named: "ic_launcher"), options: [.setImageWithFadeAnimation, .progressiveBlur]) { [unowned self](image, url, type, stage, error) in
            if image != nil {
                self.image = image!.drawRectWithRoundedCorner(radius: imageCornerRadius, self.size)
            }
        }
    }
    
    public func nice_setImage(imageURL: URL!, placeholderImage: UIImage,imageCornerRadius:CGFloat){
        
    }
    
}
