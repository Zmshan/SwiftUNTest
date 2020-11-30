//
//  FunctionViewController.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
//#pragma mark--首页最新或最热刷新
//http://47.93.149.248/appapi/tpzlk/appcourse/getcourselistbyhotornew?type=0
let  ServerUrl = "http://47.93.149.248/appapi/tpzlk/"
let  getcourselistbyhotornewAPI = (ServerUrl+"appcourse/getcourselistbyhotornew")

extension NSObject {/** 只支持属性全部是 string 类型的模型,当某个属性是 NSDictionary 或者 Array 时, json[key].stringValue 会崩溃 */
    func parseData(json:JSON) {
        
        let dic = json.dictionaryValue as NSDictionary
        let keyArr:Array = dic.allKeys
        let key:NSString?
        let property:NSString?
        
        var propertyArr:Array = [""]
        let hMirror = Mirror(reflecting: self)
        for case let (label?, _) in hMirror.children {
            propertyArr.append(label)
        }
        for property in propertyArr {
            for  key in keyArr {
                //                if key == property {
                //                    self.setValue(json[key].stringValue, forKey: key)
                //                }
            }
        }
    }
}

class FunctionViewController: UIViewController {
var noteList: NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "功能"
        // Do any additional setup after loading the view.
        self.DownLoadData();
    }
    // MARK: 下载解析数据
    func DownLoadData() -> Void {

        
//        Alamofire.request(URLConvertible, method: getcourselistbyhotornewAPI, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?)
        
//        常用的get请求
        Alamofire.request("https://httpbin.org/get", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.error == nil){
                
                LLog(response.result.value as Any)
                let json = JSON(response.result.value!)
                var dic = NSDictionary()
                dic = json["headers"].dictionary! as NSDictionary
                let headers = json["headers"]
                LLog("1111我要加载json",json,headers)
                let obj = ObjectMode()
//                obj = json["headers"]
//                obj = json["headers"].dictionary
//                obj = json["headers"] as! ObjectMode;
                LLog("请求成功",obj,dic)
                
            }else{
                LLog("请求失败\(String(describing: response.error))")
            }
            
        }
        
 
        
//        常用的post请求
        let parame = ["codeString": "1004"]
        Alamofire.request(getcourselistbyhotornewAPI, method: .post, parameters: parame, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
//            if let error = response.result.error {
//                // 出现错误
//                print("删除/posts/1出现错误")
//                print(error)
//            }
            
            
            guard response.result.error == nil else {
                // 出现错误
                print("提交到/posts时出现错误")
                print(response.result.error!)
                return
            }
            let json = JSON(response.result.value!)
            let resultCode = json["resultCode"]
            
        
             let obj = ObjectMode()
            
            
            LLog("我要加载json",json,resultCode)
            
            
//            if let value: AnyObject = response.result.value as AnyObject {
//                // 将返回值转换为JSON
//
//                let post = JSON(value)
//                print("帖子: " + post.description)
//            }
//
            
            
            
            if(response.error == nil){
                LLog("最新请求成功")
                 LLog(response.result.value as Any)
                if response.result.value != nil {
                    /*
                     error_code = 0
                     reason = ""
                     result = 数组套字典的城市列表
                     */
                    
                    
                }
                
            }else{
                LLog("最新请求失败\(String(describing: response.error))")
            }
            
        }
        
        
        
    }
   
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
