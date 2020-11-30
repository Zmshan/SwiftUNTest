//
//  MeViewController.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import UIKit
//******适配相关设备参数*********
// 判断是否是ipad
let isPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
// 判断iPhone4系列
let kiPhone4 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 判断iPhone5系列
let kiPhone5 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) : false)
// 判断iPhone6系列
let kiPhone6 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1134).equalTo((UIScreen.main.currentMode?.size)!) : false)

//判断iphone6+系列
let kiPhone6Plus = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 判断iPhoneX
let IS_IPHONE_X = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1225, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 判断iPHoneXr
let IS_IPHONE_Xr = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 判断iPhoneXs
let IS_IPHONE_Xs = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1225, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 判断iPhoneXs Max
let IS_IPHONE_Xs_Max = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 1688).equalTo((UIScreen.main.currentMode?.size)!) : false)

let Height_TabBar = ((IS_IPHONE_X == true  || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 83.0 : 49.0)

let NAVIGATIONBAR_H = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 88.0 : 64.0)
class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    var tabView = UITableView()
    var dataArr = NSMutableArray()
    var loadImage = UIImageView()
    var headerViewHeight = CGFloat()
    var headerView = MyHeadView()
    var hasFinishLayouSubview = Bool()
//    var headView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的"
        
        let dataMuArr = NSMutableArray.init(array: ["我的学习","我的考试","我的积分任务","我的下载"])
        
        let dataTwoMuArr = NSMutableArray.init(array: ["我的收藏","我的关注","我是班务"])
        let dataThreeMuArr = NSMutableArray.init(array: ["我的学习","我的考试","功能说明","设置"])
        let dataFour = NSMutableArray.init(array: ["颜色渐变+取色","饼状图"])
        self.dataArr .add(dataMuArr)
        self.dataArr .add(dataTwoMuArr)
        self.dataArr .add(dataThreeMuArr)
        self.dataArr .add(dataFour)
        
        
        //MARK:tableView
        self.tabView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGH), style: UITableView.Style.grouped)
        self.tabView.backgroundColor = BottomColor;
        self.tabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tabView.delegate = self
        self.tabView.dataSource = self
        
        self.view.addSubview(self.tabView)
        self.tabView.snp.makeConstraints {(make) in
//            make.edges.equalTo(self.view)
            make.top.equalTo(self.view.snp_top).offset(NAVIGATIONBAR_H)
            make.left.right.bottom.equalTo(self.view);
        }
        
        
       
        // 占位用的 view，高度 180
        self.headerViewHeight = 180;
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 1, height: self.headerViewHeight))
        view.backgroundColor = UIColor.clear;
        self.tabView.tableHeaderView = view;
        
        // 蓝色的 headerView
        
        self.headerView.frame = CGRect(x: 0, y: CGFloat(NAVIGATIONBAR_H), width: self.view.frame.size.width, height: self.headerViewHeight);
        self.view.addSubview(self.headerView);
        
        
//        self.loadImage = UIImageView(image:UIImage(named:"case1"))
//        //        loadImage.image = UIImage(named: "WX20180420-161313")
//        self.loadImage.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150)
//        self.loadImage.backgroundColor = UIColor.brown
//        self.view .addSubview(self.loadImage)
//        self.tabView.tableHeaderView = self.loadImage
        
        print("sjijsijsijsi",((self.dataArr[0]as AnyObject) as! NSArray)[0])
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //用一个标识防止不停地调用
        if (!self.hasFinishLayouSubview) {
            self.hasFinishLayouSubview = true;
            self.tabView.layoutIfNeeded()
            self.tabView.setContentOffset(CGPoint(x: 0, y: -100), animated: true)
           
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY:CGFloat = scrollView.contentOffset.y;
        var frame:CGRect = self.headerView.frame;
        
        if (offsetY < 0) {
            frame.size.height = self.headerViewHeight - offsetY;
            frame.origin.y = 0;             // 及时归零
        } else {
            frame.size.height = self.headerViewHeight;
            frame.origin.y = -offsetY;
        }
//        self.headerView.frame = frame;
        self.headerView.frame = CGRect(x: 0, y: frame.origin.y+CGFloat(NAVIGATIONBAR_H), width: frame.size.width, height: frame.size.height);
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetY:CGFloat = scrollView.contentOffset.y;
        if (-offsetY > 70) {
            
            print("11111");
            
        }
    }
    //MARK: - :注意大写，标注
    
    //TODO: - :注意大写，注释还有什么功能要做
    
    //FIXME: - :注意大写，项目中有个警告，不影响程序运行，当时由于时间等一些原因，做好标记，以便之后做处理。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = ((self.dataArr[indexPath.section]as AnyObject) as! NSArray)[indexPath.row] as? String

        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArr[section] as AnyObject).count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section==3 {
            switch indexPath.row {
            case 0:
               self.navigationController?.pushViewController(ZCAGradientLayerViewController.init() , animated: true);
            case 1:
                self.navigationController?.pushViewController(PieViewController.init() , animated: true);
            default: break
                
            }
            
        }else{
            self.navigationController?.pushViewController(CollectionViewViewController.init() , animated: true);
        }
    }
    //        懒加载
//     lazy var headView: UIView = UIView()
    
    lazy var headView: UIView = { () -> UIView in
        let headView = UIView()
        headView.backgroundColor = BROWNCOLOR
        headView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100)
        return headView
        
    }()
    
    
    
    
    
    
    
    
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
