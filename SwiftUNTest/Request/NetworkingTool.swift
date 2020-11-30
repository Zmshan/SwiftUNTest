//
//  NetworkingTool.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/16.
//

import UIKit
import HandyJSON
import Alamofire
import SwiftyJSON

class NetworkingTool: NSObject {
    
    static private var isFirst:Bool = true //是否是第一次点击“确定”按钮
    private static func setHttpHeader() -> HTTPHeaders {
        let Dic = Bundle.main.infoDictionary
//        let buildStr = Dic?["CFBundleVersion"] ?? "" //内部管理版本号
//        let versionStr = Dic?["CFBundleShortVersionString"] ?? "" //版本号
        //= ["os":"ios","appname":"crm","version":versionStr as! String,"Content-Type":"application/json;charset=UTF-8"]
        var header:HTTPHeaders = HTTPHeaders.init()
//        header["os"] = "iOS"
        header["Content-Type"] = "application/json;charset=UTF-8"
        header["ormpMerchantCode"] = "mcdonald876";
        return header
    }
    
    
    
    
     
    private static func ERROR() -> NSError {
        let error = NSError.init(domain: "domain", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Localised details here"])
        return error
    }
    
    
    
    
    
    
    /// 网络请求 get/post
    ///
    /// - Parameters:
    ///   - url: 链接
    ///   - method: get/post
    ///   - parameters: 参数列表
    ///   - showLoading: 是否显示loading true显示 false不显示
    ///   - succ: 请求成功 jsonStr:获取结果的json字符串。headerJsonStr:获取的header的json字符串 将返回的所有数据都返回过去，方便以后取responseHeader中的内容
    ///   - fail: 请求失败 errStr:经过处理的错误信息  err:未经整理的错误信息
    static func requestFun(url:String, method:HTTPMethod, parameters:Parameters?,showLoading:Bool = true, succ: @escaping (_ jsonStr: String, _ responseJson: DataResponse<String>) -> Void, fail: @escaping (_ errStr: String,_ err:Error)->()) {
        
    
        
        if showLoading { //显示loading
            NetworkingTool.referenceCountChangeFun(isAdd: true)
        }
        var urlStr:String = url
        let header = self.setHttpHeader()
        
        
        let encoding:ParameterEncoding = JSONEncoding.default
        
        
        if method == UNHTTPMethodGet {
            let theStr:NSString = NSString.init(string: urlStr)
            urlStr = theStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        
    
    NetManager.shareManager().request(urlStr, method: method, parameters: parameters, encoding: encoding, headers: header).responseString { (response) in
            
            if showLoading { //显示loading
                NetworkingTool.referenceCountChangeFun(isAdd: false)
            }
        
            if response.result.isSuccess { //网络请求成功
                print("header=\(header) \rurlStr=\(urlStr) \rparaDic=\(parameters ?? [:]) \rresponse=\(JSON.init(parseJSON: response.result.value ?? ""))")
                if let value = response.result.value {
                    let json = JSON.init(parseJSON: value)
                    if json["code"].int == 0 {//请求成功
                        succ(value,response)
                    }
                    else{//请求失败，获取err
                        fail(json["message"].string ?? UNNetFailMessage, response.error ?? ERROR())
                    }
                    
                }else{ //没有获取到数据
                    fail(UNNetFailMessage,  ERROR() )
                }
            }else {//网络请求失败
                fail(UNNetFailMessage, ERROR())
            }
        }
    }
    
    
    
    
    
    
    /// 文件上传
    ///
    /// - Parameters:
    ///   - url: 链接
    ///   - parameters: 参数
    ///   - name: 文件对应key
    ///   - fileName: fileName
    ///   - mimeType: mimeType
    ///   - imgData: 文件流
    ///   - showLoading: 是否显示loading true显示 false不显示
    ///   - succ: <#succ description#>
    ///   - fail: <#fail description#>
    static func uploadFun(url:String,method:HTTPMethod, parameters:Dictionary<String, String>?, name:String, fileName:String ,mimeType:String ,imgData:Data ,showLoading:Bool = true, succ: @escaping (_ jsonStr: String, _ responseJson: DataResponse<String>) -> Void, fail: @escaping (_ errStr: String,_ err:Error)->()) {
        
        let urlStr =  url
        let header = self.setHttpHeader()//请求头
        
        
        NetManager.shareManager(timeOutFlo: 60).upload(multipartFormData: { multipartFormData in
            //采用post表单上传
            // 参数解释：
            //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
            multipartFormData.append(imgData, withName: name, fileName: fileName, mimeType: mimeType)
            
            //如果需要上传多个文件,就多添加几个
            //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
            //......
            
            
            if parameters?.keys != nil && (parameters?.keys.count)! > 0{
                for str in (parameters?.keys)! {
                    let value = parameters![str]
                    multipartFormData.append((value?.data(using: String.Encoding.utf8))!, withName: str)
                }
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlStr, method: method, headers: header) { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                
                upload.responseString(completionHandler: { response in

                    
                    if response.result.isSuccess { //网络请求成功
                        print("header=\(header) \rurlStr=\(urlStr) \rparaDic=\(parameters ?? [:]) \rresponse=\(JSON.init(parseJSON: response.result.value ?? ""))")
                        if let value = response.result.value {
                            let json = JSON.init(parseJSON: value)
                            if json["code"].int == 1 || json["code"].int == 0 {//请求成功
                                succ(value,response)
                            }
                            else{//请求失败，获取err
                                fail(json["message"].string ?? UNNetFailMessage, response.error ?? ERROR())
                            }
                            
                        }else{ //没有获取到数据
                            fail(UNNetFailMessage, ERROR())
                        }
                    }else {//网络请求失败
                        fail(UNNetFailMessage, ERROR())
                    }
                    
                })
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                break
            case .failure( _):
                fail(UNNetFailMessage, ERROR())
                break
        }
    
    }
    }

    
    /// loading 管理
    ///
    /// - Parameter isAdd: 是否显示loading true引用计数加一 false引用计数减一
    private static func referenceCountChangeFun(isAdd:Bool) {
        if isAdd {
            UNNetReferenceCount += 1
            DispatchQueue.main.async {
                TMLoading.shareInstance.show(title: "正在加载")
            }
        }else{
            UNNetReferenceCount -= 1
            if UNNetReferenceCount <= 0 {
                UNNetReferenceCount = 0
                DispatchQueue.main.async {
                    TMLoading.shareInstance.dismissLoading()
                }
            }
        }
    }
    
    
    
    
    

    
    
    /// 网络请求 get/post
    ///
    /// - Parameters:
    ///   - url: 链接
    ///   - method: get/post
    ///   - parameters: 参数列表
    ///   - showLoading: 是否显示loading true显示 false不显示
    ///   - succ: 请求成功 responseModel:获取结果的模型。responseJson获取的所有信息，方便单独获取另外字段
    ///   - fail: 请求失败 errStr:经过处理的错误信息  err:未经整理的错误信息
    public static func request<T:HandyJSON>(t:T.Type,url:String, method:HTTPMethod, parameters:Parameters?,showLoading:Bool = true, succ: @escaping (_ responseModel: T, _ responseJson: DataResponse<String>) -> (), fail: @escaping (_ errStr: String,_ err:Error)->()){
        
    
        
        
        if showLoading { //显示loading
            NetworkingTool.referenceCountChangeFun(isAdd: true)
        }
        var urlStr:String = url
        var header = self.setHttpHeader()
        var encoding:ParameterEncoding = JSONEncoding.default
        
        if method == UNHTTPMethodGet {
            let theStr:NSString = NSString.init(string: urlStr)
            urlStr = theStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        
        
        NetManager.shareManager().request(urlStr, method: method, parameters: parameters, encoding: encoding, headers: header).responseString { (response) in
            
            if showLoading { //显示loading
                NetworkingTool.referenceCountChangeFun(isAdd: false)
            }
            
            if response.result.isSuccess { //网络请求成功
                print("header=\(header) \rurlStr=\(urlStr) \rparaDic=\(parameters ?? [:]) \rresponse=\(JSON.init(parseJSON: response.result.value ?? ""))")
                if let value = response.result.value {
                    let json = JSON.init(parseJSON: value)
                    if json["code"].int == 1 {//请求成功
                        
                        print("json[kNet_data_Key]原始值 == \(json["data"])")
                        print("json[kNet_data_Key].dictionaryValue == \(json["data"].dictionaryValue.keys.count)")
                        print("json[kNet_data_Key].arrayValue == \(json["data"].arrayValue.count)")
                        print("json[kNet_data_Key].stringValue == \(json["data"].stringValue.count)")
                        
                        
                        if json["data"].dictionaryValue.keys.count > 0{ //data中是数据是非空字典
                            
                            let responseModel:T = JSONDeserializer<T>.deserializeFrom(json: value, designatedPath: "data") ?? T.init()
                            succ(responseModel,response)
                        }
                        else{//是不确定类型，返回response原始值以备后续操作（空字典、空数组、空字符串等等）
                            succ(T.init(),response)
                        }
                        
                    }
                    else{//请求失败，获取err
                        fail(json["message"].string ?? UNNetFailMessage, response.error ?? ERROR())
                    }
                    
                }else{ //没有获取到数据
                    fail(UNNetFailMessage, ERROR())
                }
            }else {//网络请求失败
                fail(UNNetFailMessage, ERROR())
            }
        }
        
        
    }
    
    
    
    
    
    
}




