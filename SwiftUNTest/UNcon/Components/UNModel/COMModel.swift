//
//  COMModel.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/27.
//

import UIKit
import HandyJSON
class COMModel: HandyJSON {
    var businessType:Int = 0
    var businessValue:NSString = ""
    var mainImg:NSString = ""
    var advertName:NSString = ""
    
    var salePrice:Int = 0
    var priceUnit:NSString = ""
    var goodsName:NSString = ""
    
    var activityEndTime:NSString = ""
    var activityStatus:NSString = ""
    var activityStatusCode:NSString = ""
    var activityName:NSString = ""
    var activityId:NSString = ""
    var description:NSString = ""
    var signUpStatus:NSString = ""
    var activityBeginTime:NSString = ""
    
    var buttonCode:NSString = ""
    var buttonName:NSString = ""
    var iconDefault:NSString = ""
    var iconSelected:NSString = ""
    var size:NSString = ""
    
    required init() {}

}
