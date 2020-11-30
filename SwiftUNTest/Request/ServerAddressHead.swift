//
//  ServerAddressHead.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/16.
//
//import Foundation
import UIKit
import SnapKit
import Alamofire

let HOST = "http://mp.open-roc.com"
let HEADER_PREFIX = "/ormp/frontapi/"
let Url_Index = "industryindex"

let Address = HOST + HEADER_PREFIX
let GET_HOME = Address + Url_Index


let UNHTTPMethodGet:HTTPMethod = HTTPMethod.get
let UNHTTPMethodPost:HTTPMethod = HTTPMethod.post
let UNNetFailMessage = "请检查网络"
let UNScreenWidth = UIScreen.main.bounds.size.width
let UNScreenHeight = UIScreen.main.bounds.size.height
var UNNetReferenceCount:Int = 0

//func Address() -> NSString {
//    return  HOST + HEADER_PREFIX as NSString
//}
//func GET_HOME() -> NSString {
//    return  Address() as String + Url_Index as NSString
//}
