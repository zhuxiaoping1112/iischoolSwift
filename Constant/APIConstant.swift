//
//  APIConstant.swift
//  iischoolSwift
//
//  Created by zhu on 2019/1/4.
//  Copyright © 2019年 hank. All rights reserved.
//

import Foundation
import Moya

let niceProvider = MoyaProvider<APIConstant>()

public enum APIConstant{
    /**
     *  1.每日最美 pagesize10
     *  参数 page
     */
    case daily(Int)
    /**
     *  2.限免推荐 pagesize10
     *  参数 page
     */
    case recommend(Int)
    /**
     *  3.文章专栏
     */
    case article
    /**
     *  4.发现应用 - 最热分享
     *  参数 page
     */
    case popular(Int)
    /**
     *  5.发现应用 - 最新分享
     *  参数 pos 默认-1
     */
    case latest(Int)
    /**
     *  6.美我一下
     */
    case appStoreComment
    /**
     *  7.招聘编辑
     */
    case invite
    
    /**
     *  8.评论 app page
     */
    case comment(Int, Int)
    
    /**
     *  9.发现app评论 app_id comment_id
     */
    case findAppComment(Int, Int)
}



extension APIConstant: TargetType {
    public var path: String {
        switch self {
        case .daily(_):
            return "apps/app/daily/"
        case .recommend(_):
            return "category/100/all/"
        case .article:
            return "media/list/"
        case .popular(_):
            return "community/recommend_apps/"
        case .latest(_):
            return "community/apps/"
        case .comment(_,_):
            return "apps/comment"
        case .findAppComment(_, _):
            return "community/comments/"
        default:
            return ""
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    //Mark------------单元测试--------------

    public var sampleData: Data {
        return "{}".data(using :String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
            //每日最美
        case let .daily(page):
            let parameters :[String :Any] = ["appVerstion":appVersion,"openUDID": openUDID, "page": page, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 限免推荐
        case let .recommend(page):
            let parameters: [String: Any] = ["type": "zuimei.daily", "appVersion": appVersion, "openUDID": openUDID, "page": page, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 最热分享
        case let .popular(page):
            let parameters: [String: Any] = ["appVersion": appVersion, "openUDID": openUDID, "page": page, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 最新分享
        case let .latest(pos):
            let parameters: [String: Any] = ["appVersion": appVersion, "openUDID": openUDID, "pos": pos, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 文章专栏
        case .article:
            let parameters: [String: Any] = ["type": "zhuanlan", "appVersion": appVersion, "openUDID": openUDID, "platform": platform, "resolution": resolution, "systemVersion": systemVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 评论
        case let .comment(app, page):
            let parameters: [String: Any] = ["appVersion": appVersion, "openUDID": openUDID, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion, "app": app, "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        // 发现app评论
        case let .findAppComment(app_id, comment_id):
            let parameters: [String: Any] = ["appVersion": appVersion, "openUDID": openUDID, "page_size": 10, "platform": platform, "resolution": resolution, "systemVersion": systemVersion, "app_id": app_id, "comment_id": comment_id]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .appStoreComment:
            return .requestPlain
        case .invite:
            return .requestPlain

        }
    }
    
    
    public  var headers : [String : String]?{
        return nil
    }
    //Mark------------基本默认要传入的参数--------------
    private var appVersion : String{
        let info = Bundle.main.infoDictionary
        return info!["CFBundleShortVersionString"] as! String
    }
    
    private var openUDID : String{
        return "6784cb99acfef884d8ee056f36499e54fcc33aca"
    }
    
    /// 系统版本
    private var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    private var platform: Int {
        return 1
    }
    
    private var resolution: String {
        return "%7B750%2C%201334%7D"
    }
    
    public var baseURL : URL{
        switch self {
        case .appStoreComment:
            return URL(string: "https://itunes.apple.com/cn/app/zui-mei-ying-yong/id739652274?mt=8")!
        case .invite:
            return URL(string: "http://zuimeia.com/article/100/?utm_medium=community_android&utm_source=niceapp")!

        default:
            return URL(string: "http://zuimeia.com/api/")!
        }
    }
    
}
