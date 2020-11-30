//
//  UNHomeViewController.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/12.
//

import UIKit
import HandyJSON
import Kingfisher
import WebKit
class UNHomeViewController: UIViewController,customTitleScrollViewHeightDelegate,scrollPageToIndexDelegate,UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate  {
//    var bannerView: UNBannerView!
    var tabView = UITableView()
    var tableHeaderView = UIView()
    var bannerView = UNBannerView()
    var titleScrollView = UNColumnBtns()
    var bannerImageArr:NSMutableArray = []
    var topBtnsArr:NSMutableArray = []
    var tabNumList:NSMutableArray = []
   
    lazy  var dicData:NSMutableDictionary = {
                var  view  =  NSMutableDictionary.init()
//                view.backgroundColor = UIColor .purple;
                return view
            }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red;


        self.loadUI()
//        self.loadRequestData()
        self.loadJsonData()
//        self.loadWKweb()

    }
    func loadWKweb() -> Void {
        //创建wkwebview
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        webview.uiDelegate = self
        webview.navigationDelegate = self
            //创建网址
//            let url = NSURL(string: "http://www.jianshu.com/users/040395b7230c/latest_articles")
        let urlStrA = "http://wx-test.lemobar.cn/o2o-test-two/#/commonQr"
        let urlStr = "http://wx-test.lemobar.cn/o2o-test-two/#/detectionList"
        
        
        let urlStrBackUrl = "back_url=http://wx-test.lemobar.cn/o2o-test-two/#/detectionList?open_id="
        let urlStrTest = "http://wx-test.lemobar.cn/o2o-test-two/#/commonQr?" + urlStrBackUrl.urlEncoded()
        let urlAA:NSURL = NSURL(string: urlStrTest)!
            //创建请求
        let request = NSURLRequest(url: urlAA as URL)
            //加载请求
        webview.load(request as URLRequest)
            //添加wkwebview
        self.view.addSubview(webview)
    }
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webViewA",webView)
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webViewB",webView)
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webViewC",webView)
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("webViewD",webView)
    }
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("webViewE",webView)
    }
    // 在收到响应后，决定是否跳转 -> 默认允许
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //允许跳转
        decisionHandler(.allow)
        //不允许跳转
//        decisionHandler(.cancel)
    }


    @objc func loadUI(){
    
        //MARK:tableView
        let banY:CGFloat = CGFloat(NAVIGATIONBAR_H);
        self.tabView = UITableView.init(frame: CGRect(x: 0, y: banY, width: self.view.frame.size.width, height: self.view.frame.size.height-banY), style: UITableView.Style.plain)
        self.tabView.backgroundColor = UIColor.white;
        self.tabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tabView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "Activitycell")
        self.tabView.register(UNTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headview")
        self.tabView.delegate = self
        self.tabView.dataSource = self
        self.tabView.estimatedRowHeight = 44.0
        self.tabView.rowHeight = UITableView.automaticDimension
        self.tabView.separatorStyle = .none
//        self.tabView.tableHeaderView =  self.headerView()
        self.view.addSubview(self.tabView)
        
       
    }
   
    func headerView() -> UIView   {
        let head:UIView = UIView.init()
        let sizeWidth:CGFloat = self.view.frame.size.width;
        let banHeight:CGFloat = 200;
        head.frame = CGRect(x: 0,y: 0,width: sizeWidth,height: banHeight)
        self.bannerView.frame = CGRect(x: 0, y: 0, width: sizeWidth, height: banHeight)
        head.addSubview(self.bannerView)
        print("bannerImageArr.count",bannerImageArr.count)
        if(bannerImageArr.count != 0){
            self.bannerView.setImages(images:  bannerImageArr as! Array<String>,type: UNBannerView.ImageType.URL){ (index) in
                        print(index)
            }
        }else{
            self.bannerView.setImages(images: ["banner_1","active02","banner_1"]){ (index) in
                        print(index)
            }
        }
        
        
       
        let  titleScroll  =  UNColumnBtns.init()
        titleScroll.heightDelegate = self
        titleScroll.titleScrollView.bounces = false
        titleScroll.backgroundColor = UIColor.yellow;
//        titleScroll.titleScrollView.backgroundColor = UIColor.white;
        head.addSubview(titleScroll);
        titleScroll.snp_makeConstraints { (make) in
            make.left.right.equalTo(head);
            make.top.equalTo(self.bannerView.snp_bottom).offset(0);
            make.height.equalTo(0);
        }
        head.layoutIfNeeded();
        
        let btnDIcA:NSDictionary = ["最新活动":"icon_active"];
        let btnDIcB:NSDictionary = ["会员权益":"icon_equity"];
        let btnDIcC:NSDictionary = ["积分商城":"icon_Integralmall"];
        let btnDIcD:NSDictionary = ["邀请好友":"icon_Invitefriends"];
        let btnArr:NSArray = [btnDIcA,btnDIcB,btnDIcC,btnDIcD];
        
        let titleBtnArr:NSArray = ["我要显示1","我要显示2","我要显示3"];
        if(self.topBtnsArr.count != 0){
            titleScroll.presentationStyle = showStyle.circularStyle
            titleScroll.titlesArr = topBtnsArr;
        }else{
            titleScroll.presentationStyle = showStyle.defaultStyle
            titleScroll.titlesArr = titleBtnArr;
            
//            titleScroll.presentationStyle = showStyle.circularStyle
//            titleScroll.titlesArr = btnArr;
        }
        titleScroll.customBlockFunction { (str) in
            print(str as Any)
        }
        self.titleScrollView = titleScroll;
        let titleScrollHeight:CGFloat = titleScroll.frame.size.height;
        head.frame = CGRect(x: 0,y: 0,width: sizeWidth,height: banHeight+titleScrollHeight)
        tableHeaderView = head;
        return head
    }
    
    func loadJsonData() -> Void {
        let path = Bundle.main.path(forResource:"jsonData", ofType: "json")
        do{

            let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
            let model:NSDictionary =  jsonData! as NSDictionary;
            if let modelA = JSONDeserializer<HomeModel>.deserializeFrom(dict:model){
                print("json获取成功了",modelA.data as Any)
            }
            if let modelB = JSONDeserializer<columnList>.deserializeFrom(dict: model , designatedPath: "data") {
                print("json获取成功了B",modelB.columnList as Any)
               
                self.bannerImageArr = NSMutableArray.init()
                self.topBtnsArr = NSMutableArray.init()
//                let columItemList = NSMutableArray.init()
                let arr:NSArray = modelB.columnList! as NSArray;
                arr.enumerateObjects { (obj, idx, stop) in
                    let mode:columnListModel = obj as! columnListModel;
                    print("columnListModel",mode)
                    let subModel:NSArray = mode.columnData! as NSArray;
                    if(mode.columnType == "carousel"){
                        subModel.enumerateObjects { (subObj, subIdx, subStop) in
                            let item:columnDataAllModel = subObj as! columnDataAllModel;
                            let mainImg:NSString =  item.mainImg
                            var str =  HOST
                            str.append(mainImg as String)
                            self.bannerImageArr .add(str)
        
                        }
                                            
                    }else if(mode.columnType == "button_main"){
                        
                        subModel.enumerateObjects { (subObj, subIdx, subStop) in
                            let item:columnDataAllModel = subObj as! columnDataAllModel;
                            let iconDefault =   item.iconDefault as String
                            var str =  HOST
                            str.append(iconDefault as String)
                            let buttonName = item.buttonName as String
                            self.topBtnsArr .add([buttonName:str])
                         
                        }
                        
                    }else if(mode.columnType == "goods_oil"){
                       
                        self.tabNumList .add(obj)
                    }
                    else if(mode.columnType == "activity"){
                        self.tabNumList .add(obj)
                    }
                    print("subModel",subModel as Any)
                        
                }
            }
                self.tabView.tableHeaderView =  self.headerView()

        }catch  let error as Error? {

            print("读取本地数据出现错误！",error)

        }
    }
    func loadRequestData() -> Void {
        
        HomeModel.requestFun(succ: { [self] (model) in

            if let modelA = JSONDeserializer<HomeModel>.deserializeFrom(json: model as String, designatedPath: "") {
                print("网络请求成功了A",modelA.data as Any)
            }
          
            if let modelB = JSONDeserializer<columnList>.deserializeFrom(json: model as String, designatedPath: "data") {
                print("网络请求成功了B",modelB.columnList as Any)
               
                self.bannerImageArr = NSMutableArray.init()
                self.topBtnsArr = NSMutableArray.init()
//                let columItemList = NSMutableArray.init()
                let arr:NSArray = modelB.columnList! as NSArray;
                arr.enumerateObjects { (obj, idx, stop) in
                    let mode:columnListModel = obj as! columnListModel;
                    print("columnListModel",mode)
                    let subModel:NSArray = mode.columnData! as NSArray;
                    if(mode.columnType == "carousel"){
                        subModel.enumerateObjects { (subObj, subIdx, subStop) in
                            let item:columnDataAllModel = subObj as! columnDataAllModel;
                            let mainImg:NSString =  item.mainImg
                            var str =  HOST
                            str.append(mainImg as String)
                            self.bannerImageArr .add(str)
        
                        }
                                            
                    }else if(mode.columnType == "button_main"){
                        
                        subModel.enumerateObjects { (subObj, subIdx, subStop) in
                            let item:columnDataAllModel = subObj as! columnDataAllModel;
                            let iconDefault =   item.iconDefault as String
                            var str =  HOST
                            str.append(iconDefault as String)
                            let buttonName = item.buttonName as String
                            self.topBtnsArr .add([buttonName:str])
                         
                        }
                        
                    }else if(mode.columnType == "goods_oil"){
                       
                        self.tabNumList .add(obj)
                    }
                    else if(mode.columnType == "activity"){
                        self.tabNumList .add(obj)
                    }
                    print("subModel",subModel as Any)
                        
                }
                
                self.tabView.tableHeaderView =  self.headerView()
            }
        }) { (errStr) in
            print("失败了")
        }
    }
    
//    代理方法
    func customTitleScrollViewHeight(height: CGFloat) {
        print("customTitleScrollViewHeight",height)
        let sizeWidth:CGFloat = self.view.frame.size.width;
        let banHeight:CGFloat = 200;
        let titleScrollHeight:CGFloat = self.titleScrollView.frame.size.height;
        self.tableHeaderView.frame = CGRect(x: 0,y: 0,width: sizeWidth,height: banHeight+titleScrollHeight)
//        self.tabView.tableHeaderView=self.tableHeaderView;
        self.tabView.reloadData()
    }
    func scrollPageToIndexBlock(index: NSInteger) {
        print("scrollPageToIndexBlock",index)
    }
    
    
    
    //MARK: - :注意大写，标注
     
    //TODO: - :注意大写，注释还有什么功能要做
     
    //FIXME: - :注意大写，项目中有个警告，不影响程序运行，当时由于时间等一些原因，做好标记，以便之后做处理。
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let mode:columnListModel = self.tabNumList[indexPath.section] as! columnListModel
        print("columnListModel",mode)
        if (mode.columnType == "activity") {
            var cell = ActivityTableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "Activitycell")! as! ActivityTableViewCell
           let subModel:NSArray = mode.columnData! as NSArray
            let item:columnDataAllModel = subModel[indexPath.row] as! columnDataAllModel
            let itemData =  item.toJSONString();
            cell.objectFun(jsonData: itemData as Any)
            return cell
            
        }else{
            var cell = UITableViewCell()
            cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
           let subModel:NSArray = mode.columnData! as NSArray
           
           let item:columnDataAllModel = subModel[indexPath.row] as! columnDataAllModel
           let mainImg:NSString =  item.mainImg
           var str =  HOST
           str.append(mainImg as String)
           cell.textLabel?.text = str;
            return cell
        }
         
//         cell.textLabel?.text = (self.dataArr[indexPath.row] as? String)!+String(indexPath.row);
         
        
        
        
        
     }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return  self.tabNumList.count
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let mode:columnListModel = self.tabNumList[section] as! columnListModel
        print("columnListModel",mode)
        let subModel:NSArray = mode.columnData! as NSArray
        return subModel.count
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let mode:columnListModel = self.tabNumList[indexPath.section] as! columnListModel
        print("columnListModel",mode)
        if (mode.columnType == "activity") {
            return UITableView.automaticDimension
        }else{
            return 50
        }
         
     }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        let data =  dicData.object(forKey: section)
        var headview:UNTableHeaderFooterView
        if (data != nil) {
            headview = dicData.object(forKey: section) as! UNTableHeaderFooterView
        }else{
            headview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headview") as! UNTableHeaderFooterView
            
            let mode:columnListModel = self.tabNumList[section] as! columnListModel
            
            var title:NSString = mode.columnTitle;
            if (title.length == 0) {
                title = "最新资讯"
            }
            headview.leftText.text = title as String;
            headview.rightText.text = "加载更多";
            headview.setNeedsLayout()
            headview.layoutIfNeeded()
            dicData.setObject(headview, forKey: section as NSCopying)
        }
        headview.headOrFootBlockFunction { (str) in
            print(str as Any)
            headview.isOPenFunction(isOpen: headview.headIsOpen);
            headview.setNeedsLayout()
            headview.layoutIfNeeded()
            self.dicData.setObject(headview, forKey: section as NSCopying)
            UIView.performWithoutAnimation {
                self.tabView.reloadSections(IndexSet.init(integer: section), with: UITableView.RowAnimation.automatic)
            }
            UIView.performWithoutAnimation {
                self.tabView.reloadData()
            }
        }
        return headview.rightView.frame.size.height
     }
     
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
        return 0.00001
     }
 //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
 //        return 64
 //    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let headview:UNTableHeaderFooterView = dicData.object(forKey: section) as! UNTableHeaderFooterView
        headview.contentView.backgroundColor = UIColor.green
        return headview
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let headview:UNTableHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headview") as! UNTableHeaderFooterView
//        headview.contentView.backgroundColor = UIColor.red
//        return headview
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension String {
     
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
     
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
