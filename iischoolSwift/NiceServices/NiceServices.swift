//
//  NiceServices.swift
//  iischoolSwift
//
//  Created by junke on 2019/2/28.
//  Copyright © 2019 hank. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya

class NiceServices {
    static let shareInstance = NiceServices()
    private init(){}
}

extension NiceServices {
    public func getHomeData(target :APIConstant ,successHandle:((Array<HomeModel>) -> Void)?){
        niceProvider.request(target) { result in
            switch result{
            case let .success(response):
                do{
                let json = try response.mapJSON() as! NSDictionary
                    guard let content = json["data"] as? NSDictionary else{
                        print(json)
                        return
                    }
                    guard let contentArray = content["apps"] as? Array<NSDictionary> else{
                        print("请求数据出错---",content)
                        return
                    }
                    DispatchQueue.global().async {
                        let data = contentArray.map({ (dict) -> HomeModel in
                            HomeModel(dict: dict)
                        })
                        
                        DispatchQueue.main.async {
                            if let success = successHandle {
                                success(data)
                            }
                        }
                    }
                }catch{
                    print("数据异常",result)
                }
                
            default:
                break
            }
        }
    }
    
}
