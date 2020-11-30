//
//  PrefixHeader.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

//import Foundation
import UIKit
import SnapKit
import Alamofire
import Kingfisher
import SwiftyJSON

//自定义宏
let  SCREEN_WIDTH = UIScreen.main.bounds.width
let  SCREEN_HEIGH = UIScreen.main.bounds.height
let  WHITECOLOR = UIColor.white
let  BLUECOLOR = UIColor.blue
let  REDCOLOR = UIColor.red
let  BROWNCOLOR = UIColor.brown
let  BottomColor = UIColorFromRGB(rgbValue: 0xF4F4F4)

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func LLog(_ message:Any..., file:String = #file, function:String = #function,
          line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) 方法：\(function) 信息：\(message)")
    #endif
}
