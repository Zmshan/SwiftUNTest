//
//  NetManager.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/16.
//

import UIKit
import Alamofire
/// 网络配置单例类
class NetManager: SessionManager {
    
    static var theManager:NetManager?
    
    class func shareManager(timeOutFlo:TimeInterval = 60) -> NetManager {
        
        let config = Config.shareConfig()
        config.timeoutIntervalForRequest = timeOutFlo
        
        if theManager == nil{
            theManager = NetManager.init(configuration: config)
        }

        return theManager!
    }
    
}





/// 网络配置单例类
class Config: URLSessionConfiguration {
    static var theConfig:URLSessionConfiguration?
    class func shareConfig() -> URLSessionConfiguration {
        if theConfig == nil {
            theConfig = URLSessionConfiguration.default
        }
        return theConfig!
    }
}



