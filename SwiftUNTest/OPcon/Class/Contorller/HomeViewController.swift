//
//  HomeViewController.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UIScrollViewDelegate{
    var label = UILabel()
    var loadImage = UIImageView()
    var dataArr = NSMutableArray()
    var tabView = UITableView()
    var realTextSpace = CGFloat() //实际的文本间距
    var realTextHeight = CGFloat() //实际的文本间距
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.red;
        
        
        self.dataArr .add("老张")
        self.dataArr .add("老王")
        self.dataArr .add("老李")
        self.dataArr .add("哈哈")
        
        
        let leftBtn = UIBarButtonItem.init(title: "left", style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftBtnClick))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        let rightBtn = UIBarButtonItem.init(title: "right", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightBtnClick))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        
        let button:UIButton = UIButton(type: .custom)
        //        let button = UIButton.init()
        //        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        button.setTitle("小王", for: UIControl.State.normal)
        button.backgroundColor = UIColor.green
        
        button.addTarget(self, action: #selector(ViewController.disbtn), for: UIControl.Event.touchUpInside)
        
        self.view .addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(100)
            make.right.equalTo(-100)
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY)
            
        }
        
        self.label = UILabel.init()
        self.label.frame = CGRect(x: 50, y: 64, width: 200, height: 100)
        self.label.text = "想想想想想想想"
        self.label.textColor = UIColor.black
        self.label.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(self.label)
        
        //        懒加载
        //        lazy var wkWebView: WKWebView = { () -> WKWebView in
        //            let tempWebView = WKWebView()
        //            tempWebView.navigationDelegate = self
        //            return tempWebView }()
        
        
        //        let loadImage = UIImageView()
        
        
        
        
        self.loadImage = UIImageView(image:UIImage(named:"WX20180420-161313"))
        //        loadImage.image = UIImage(named: "WX20180420-161313")
        self.loadImage.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        self.loadImage.backgroundColor = UIColor.brown
        self.view .addSubview(self.loadImage)
        
        //     MARK:延时
        //        perform(#selector(ViewController.change), with: self, with: 2)
        perform(#selector(change), with: nil, afterDelay: 2)
        //延时1秒执行
        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("1 秒后输出")
        }
        
        //      MARK: 遍历
        let arr = NSMutableArray()
        
        arr.add("12")
        arr.add("13")
        arr.add("14")
        
        for str in arr {
            print(str)
        }
        arr.enumerateObjects { (obj, idx, count) in
            print("输出",arr[idx],count)
        }
        
        
        //MARK:tableView
        self.tabView = UITableView.init(frame: CGRect(x: 0, y: 400, width: self.view.frame.size.width, height: 200), style: UITableView.Style.grouped)
        self.tabView.backgroundColor = UIColor.white;
        self.tabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tabView.delegate = self
        self.tabView.dataSource = self
        
        self.view.addSubview(self.tabView)
        
        
        //MARK:scrollView
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.blue
        scrollView.frame = CGRect(x: 100, y: 200, width: 100, height: 150)
        scrollView.delegate = self
        
        //        scrollView.enable = NO;//（仅仅是让scrollView不能滚动）
        scrollView.contentSize = CGSize(width: 100, height: 200)
        scrollView.isUserInteractionEnabled = true;
        
        //设置滚动条
        //是否显示水平滚动条
        scrollView.showsHorizontalScrollIndicator = true
        
        //是否显示竖直滚动条
        scrollView.showsVerticalScrollIndicator = true
        
        //设置分页滚动
        scrollView.isPagingEnabled = true
        
        //设置是否可以拉出空白区域
        scrollView.bounces = true
        self.view .addSubview(scrollView)
        
        
        
        
        let name = UILabel()
        name.text = "scrollView";
        name.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        scrollView .addSubview(name)
        
        
    }
    //MARK:--leftBtnClick
    @objc func leftBtnClick(){
        self.tabView .reloadData()
        self.loadImage.image = UIImage(named:"WX20180420-161313")
        print("leftBtn")
    }
    //MARK:--rightBtnClick
    @objc func rightBtnClick(){
        
        self.dataArr .add("老张")
        self.dataArr .add("老王")
        self.dataArr .add("老李")
        self.dataArr .add("哈哈")
        self.tabView .reloadData()
        self.loadImage.image = UIImage(named:"WX20180420-160446")
        print("rightBtn")
    }
    
    //MARK:改变图片
    @objc func change(){
        
        print("改变图片")
        self.loadImage.image = UIImage(named:"83E55B37D22251BE1939E206145D409F.jpg")
    }
    
    
    @objc func disbtn() {
        print("select new button")
        let firstVc = FirstViewController.init()
        
        firstVc.customeCloser = {(cusValue) -> () in
            //cusValue就是传过来的值
            //            self.title = cusValue
            self.label.text = cusValue
            self.loadImage.image = UIImage(named:"WX20180420-160446")
        }
        
        self.navigationController?.pushViewController(firstVc, animated: true)
        
    }
    
   
    
    //MARK: - :注意大写，标注
    
    //TODO: - :注意大写，注释还有什么功能要做
    
    //FIXME: - :注意大写，项目中有个警告，不影响程序运行，当时由于时间等一些原因，做好标记，以便之后做处理。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = (self.dataArr[indexPath.row] as? String)!+String(indexPath.row);
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = GameViewViewController()
        self.navigationController?.pushViewController(game, animated: true)
        
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    //        return 64
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

