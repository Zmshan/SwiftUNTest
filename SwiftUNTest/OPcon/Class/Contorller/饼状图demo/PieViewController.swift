//
//  PieViewController.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/28.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit


func RGBColor(r :CGFloat ,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor.init(_colorLiteralRed: Float(r / 255.0), green:Float(g / 255.0) , blue:Float (b / 255.0), alpha: 1)
}

let PhoneScreen_HEIGHT = UIScreen.main.bounds.size.height
let PhoneScreen_WIDTH = UIScreen.main.bounds.size.width

class PieViewController: UIViewController {
    
    private var chartView = CustomPieView()
    private var segmentDataArray = NSMutableArray()
    private var segmentTitleArray = NSMutableArray()
    private var segmentColorArray = NSMutableArray()
    private var chartWidth = NSInteger()
    private var chartHeight = NSInteger()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPieData()
        self.loadPieChartView()
        
    }
    

    func loadPieData() -> Void {
        
        chartWidth = NSInteger(PhoneScreen_WIDTH - 20);
        
        chartHeight = 300;
        segmentDataArray = NSMutableArray.init(array: ["2","2","3","1","4"])
        segmentTitleArray = NSMutableArray.init(array: ["提莫","拉克丝","皇子","EZ","布隆"])
        
         segmentColorArray = NSMutableArray.init(array: [UIColor.red,UIColor.red,UIColor.orange,UIColor.green,UIColor.brown])
        self.view.backgroundColor = UIColor.white
    }
    
    func loadPieChartView() -> Void {
        
        //包含文本的视图frame
        chartView = CustomPieView.init(frame: CGRect(x: 10, y: 100, width: chartWidth, height: chartHeight))
        
        //数据源
        chartView.segmentDataArray = segmentDataArray;
        
        //颜色数组，若不传入，则为随即色
        chartView.segmentColorArray = segmentColorArray;
        
        //标题，若不传入，则为“其他”
        chartView.segmentTitleArray = segmentTitleArray;
        
        //动画时间
        chartView.animateTime = 2.0;
        
        //内圆的颜色
        chartView.innerColor = UIColor.white;
        
        //内圆的半径
        chartView.innerCircleR = 10;
        
        //大圆的半径
        chartView.pieRadius = 60;
        //整体饼状图的背景色
        chartView.backgroundColor = RGBColor(r: 240, g: 241, b: 242)
        
        //圆心位置，此属性会被centerXPosition、centerYPosition覆盖，圆心优先使用centerXPosition、centerYPosition
        chartView.centerType = .PieCenterTypeTopMiddle;
        
        //是否动画
        chartView.needAnimation = true;
        
        //动画类型，全部只有一个动画；各个部分都有动画
        chartView.type = .PieAnimationTypeTogether;
        
        //圆心，相对于饼状图的位置
        chartView.centerXPosition = 70;
        
        //右侧的文本颜色是否等同于模块的颜色
        chartView.isSameColor = false;
        
        //文本的行间距
        chartView.textSpace = 20;
        
        //文本的字号
        chartView.textFontSize = 12;
        
        //文本的高度
        chartView.textHeight = 30;
        
        //文本前的颜色块的高度
        chartView.colorHeight = 10;
        
        //文本前的颜色块是否为圆
        chartView.isRound = true;
        
        //文本距离右侧的间距
        chartView.textRightSpace = 20;
        
        //支持点击事件
        chartView.canClick = true;
        
        //点击圆饼后的偏移量
        chartView.clickOffsetSpace = 10;
        
        //不隐藏右侧的文本
        chartView.hideText = false;
        
//        chartView.clickBlock = {
//            (index: NSInteger) -> Void in
//
//           print("Click Index:%ld",index)
//
//        }
    
        //点击触发的block，index与数据源对应
        chartView.clickPieView { (index:NSInteger) -> Void in
            print("Click Index:%ld",index)
        }
        
        //添加到视图上
        chartView.showCustomViewInSuperView(superView: self.view)
        
        //设置默认选中的index，如不需要该属性，可注释
        //[chartView setSelectedIndex:2];
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loadNewDataArray()
        self.loadNewColorArray()
        let index:NSInteger = self.getRandomNumber(from: 1, to: 16)
        
        if (index == 1) {
            
            //更新半径
            chartView.pieRadius = 70;
            
        }else if (index == 2){
            
            //更新内圆颜色
            chartView.innerColor = UIColor.black;
            
        }else if (index == 3){
            
            //更新内圆半径
            chartView.innerCircleR = 15;
            
            
        }else if (index == 4){
            
            //更新背景色
            chartView.backgroundColor = UIColor.lightGray;
            
            
        }else if (index == 5){
            
            //更新大圆半径
            chartView.pieRadius = 80;
            
            
        }else if (index == 6){
            
            //更新动画类型
            chartView.type = .PieAnimationTypeOne;
            
            
        }else if (index == 7){
            
            //更新圆心位置
            chartView.centerXPosition =  80;
            chartView.centerYPosition = 150;
            
        }else if (index == 8){
            
            //更新文本颜色与圆点颜色一致
            chartView.isSameColor = true;
            
            
        }else if (index == 9){
            
            //更新文本行间距
            chartView.textSpace = 15;
            
            
        }else if (index == 10){
            
            //更新文本高度
            chartView.textHeight = 20;
            
            
        }else if (index == 11){
            
            //更新文本前圆点的高度
            chartView.colorHeight = 15;
            
            
        }else if (index == 12){
            
            //更新文本前的圆点为圆
            chartView.isRound = false;
            
            
        }else if (index == 13){
            
            //更新文本右侧间距
            chartView.textRightSpace = 5;
            
//            shapeLayer.convert(point, from: shapeLayer)
//            self.view.frame.contains(<#T##point: CGPoint##CGPoint#>)
            
        }else if (index == 14){
            
            //更新点击后的偏移量
            chartView.clickOffsetSpace = 30;
            
        }else if (index == 15){
            
            //移除文本，圆饼居中
            chartView.hideText = true;
            chartView.pieRadius = 100;
            chartView.centerXPosition = 0;
            chartView.centerYPosition = 0;
            chartView.centerType = .PieCenterTypeCenter;
        }
        
        chartView.updatePieView()
        
    }
    func loadNewDataArray() -> () {
        
        
        let dataCount:NSInteger = self.getRandomNumber(from: 1, to: 7)
        let dataArray = NSMutableArray()
        
        for i in 0..<dataCount{
            let value = self.getRandomNumber(from: 1, to: 20)
            let valueString = NSString(format:"%ld",value)
            dataArray.add(valueString)
        }
       
        chartView.segmentDataArray = dataArray;
    }
    func loadNewColorArray() -> () {
        let colorArray = NSMutableArray()
        for i in 0..<chartView.segmentDataArray.count{
            let red:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
            let green:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
            let blue:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
            
            let color:UIColor = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1/0)
            
           colorArray.add(color)
            
        }
        
        chartView.segmentColorArray = colorArray;
    }
    
    func getRandomNumber(from:Int,to:Int) -> Int {
       
        let tt:Int = (to - from)
        let myUInt32 = UInt32(tt)
        return (Int)(from + Int((arc4random() % myUInt32)))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
