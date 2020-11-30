//
//  HomeModel.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/16.
//

import UIKit
import HandyJSON


class HomeModel: HandyJSON {
    
    var message:String = ""
    var code: Int? // 服务端返回码
    var data: Any? // 具体的data的格式和业务相关，故用泛型定义
//    var newestActivities:NSArray = []
//    var specialGoodsList:NSArray = []
//    var topAdvert:NSArray = []
//    var newestNews:NSArray = []
//    var topFunctionButtons:NSArray = []
//    var exchangeableGifts:NSArray = []
    
//    var captcha:Bool = false
    

    //HandyJSON要求必须实现这个方法
    required init() {
        
    }
  

    /// 获取个人信息
    /// - Parameters:
    ///   - succ: <#succ description#>
    ///   - fail: <#fail description#>
//    static func requestFun(succ: @escaping(_ arr:Array<HomeModel>) -> (), fail: @escaping (_ errStr: String) -> ()) {
    static func requestFun(succ: @escaping (_ responseJson: NSString) -> (), fail: @escaping (_ errStr: String) -> ()) {
        
        NetworkingTool.requestFun(url: GET_HOME, method: UNHTTPMethodPost, parameters: nil, showLoading: false, succ: { (responseData, response) in
            succ(responseData as NSString)
           
        }) { (errStr, err) in
            fail(errStr)
        }
    }
    

}
class  columnList: HandyJSON {
    
    var columnList:[columnListModel]?
   
    required init() {}

}
class  columnListModel: HandyJSON {
    
    var columnTitle:NSString = ""
    var columnType:NSString = ""
    var columnData:[columnDataAllModel]?
    required init() {}

}

class  columnDataAllModel: HandyJSON {
    var businessType:Int = 0
    var businessValue:NSString = ""
    var mainImg:NSString = ""
    var advertName:NSString = ""
    
    var salePrice:Int = 0
    var priceUnit:NSString = ""
    var goodsName:NSString = ""
    
    var activityEndTime:NSString = ""
//    var mainImg:NSString = ""
    var activityStatus:NSString = ""
    var activityStatusCode:NSString = ""
var activityName:NSString = ""
var activityId:NSString = ""
var description:NSString = ""
var signUpStatus:NSString = ""
var activityBeginTime:NSString = ""
    
//    var businessType:Int = 0
//    var businessValue:NSString = ""
    var buttonCode:NSString = ""
    var buttonName:NSString = ""
    var iconDefault:NSString = ""
    var iconSelected:NSString = ""
    var size:NSString = ""
    
    required init() {}

}

class  columnDataModel: HandyJSON {
    var activity:[activityModel]?
    var goods_oil:[goods_oilModel]?
    var button_main:[button_mainModel]?
    var carousel:[carouselModel]?
    required init() {}

}
class  carouselModel: HandyJSON {
            var businessType:Int = 0
            var businessValue:NSString = ""
            var mainImg:NSString = ""
            var advertName:NSString = ""
            required init() {}

}
class  goods_oilModel: HandyJSON {
            var salePrice:Int = 0
            var priceUnit:NSString = ""
            var goodsName:NSString = ""
            required init() {}
}

class  activityModel: HandyJSON {
            var activityEndTime:NSString = ""
            var mainImg:NSString = ""
            var activityStatus:NSString = ""
            var activityStatusCode:NSString = ""
    var activityName:NSString = ""
    var activityId:NSString = ""
    var description:NSString = ""
    var signUpStatus:NSString = ""
    var activityBeginTime:NSString = ""
    required init() {}

}

class  button_mainModel: HandyJSON {
    
            var businessType:Int = 0
            var businessValue:NSString = ""
            var buttonCode:NSString = ""
            var buttonName:NSString = ""
            var iconDefault:NSString = ""
            var iconSelected:NSString = ""
            var size:NSString = ""
            required init() {}

}
