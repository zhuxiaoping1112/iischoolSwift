//
//  Reusable.swift
//  iischoolSwift
//
//  Created by junke on 2019/1/3.
//  Copyright © 2019 hank. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable : class{
    static var reuseIdentifier : String{get}
}

extension Reusable {
    static var reuseIdentifier : String{
        return String(describing: self)
    }
}

//MARK: 扩展tableview collectionView 不用传入identifire参数 identifire为类名
public extension UICollectionView {
    public func dequeueReusableCell<T:Reusable>(indexPath : IndexPath) ->T{
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: IndexPath)
    }
    
    func registerClass<T: UICollectionViewCell>(_:T.Type) where T:Reusable {
        self.registerClass(T.self,forwardingTarget(for: T.reuseIdentifier))
    }
}
