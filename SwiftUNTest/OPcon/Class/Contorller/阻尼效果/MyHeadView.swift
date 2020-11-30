//
//  MyHeadView.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/22.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
enum HeadDrawType:Int {
    case  DrawTypeA = 0               // A
    case  DrawTypeB = 1               // B
    case  DrawTypeC = 2               // C
    case  DrawTypeD = 3               // D
}
class MyHeadView: UIView {
var loadImage = UIImageView()
    var drawType = HeadDrawType.DrawTypeA
    var headerViewHeight = CGFloat()
    var screenWidth = CGFloat()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.headerViewHeight = 180;
        self.screenWidth = UIScreen.main.bounds.size.width
        
        
        self.loadImage = UIImageView(image:UIImage(named:"icon_head"))
        //        loadImage.image = UIImage(named: "WX20180420-161313")
        self.loadImage.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        self.loadImage.backgroundColor = UIColor.clear
        self .addSubview(self.loadImage)
        self.loadImage.isUserInteractionEnabled = true;
        self.loadImage .addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MyHeadView.disbtn)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let yy:CGFloat = 60+(self.frame.size.height-self.headerViewHeight)*0.6
        // imageV 是 60 * 60 的
        self.loadImage.frame = CGRect(x: (self.screenWidth - 60) * 0.5,y: yy, width: 60, height: 60)
        
        self.setNeedsDisplay()// 重绘
    
    }
    
    override func draw(_ rect: CGRect) {
        switch drawType {
        case .DrawTypeA:
            self.drawA(in: rect)
            break
        case .DrawTypeB:
            self.drawB(in: rect)
            break
        case .DrawTypeC:
            self.drawC(in: rect)
            break
        case .DrawTypeD:
            self.drawD(in: rect)
            break
            
        
            
        }
    }
    
    @objc func disbtn() {
        print("select new button")
        switch drawType {
        case .DrawTypeA:
            drawType = .DrawTypeB;
            self.setNeedsDisplay()// 重绘
            break
        case .DrawTypeB:
            drawType = .DrawTypeC;
            self.setNeedsDisplay()// 重绘
            break
        case .DrawTypeC:
            drawType = .DrawTypeD;
            self.setNeedsDisplay()// 重绘
            break
        case .DrawTypeD:
            drawType = .DrawTypeA;
            self.setNeedsDisplay()// 重绘
            break
        
        }
   
      
    }
    func drawA(in rect: CGRect){
        //获取上下文
        //CGContextRef 用来保存图形信息.输出目标
        //        let context = UIGraphicsGetCurrentContext()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //设置颜色
        context.setFillColor(red: 0.00392, green: 0.54117, blue: 0.85098, alpha: 1.0)
        
        
        let h1:CGFloat  = self.headerViewHeight;
        let w:CGFloat  = rect.size.width;
        let h:CGFloat  = rect.size.height;
        
       
        
        //起点
        context.move(to: CGPoint(x: w, y: h1))
        //画线
        context.addLine(to: CGPoint(x: w, y:0))
        context.addLine(to: CGPoint(x: 0, y:0))
        context.addLine(to: CGPoint(x: 0, y:h1))
        context.addQuadCurve(to: CGPoint(x: w, y:h1), control: CGPoint(x: w*0.5, y:h + (h - h1) * 0.6))
        //闭合
        context.closePath()
        context.drawPath(using: CGPathDrawingMode.fill)
        
    }
    func drawB(in rect: CGRect){
        //获取上下文
        //CGContextRef 用来保存图形信息.输出目标
        //        let context = UIGraphicsGetCurrentContext()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //设置颜色
        context.setFillColor(red: 0.00392, green: 0.54117, blue: 0.85098, alpha: 1.0)
        
        
        let h1:CGFloat  = self.headerViewHeight;
        let w:CGFloat  = rect.size.width;
        let h:CGFloat  = rect.size.height;
        
        //起点
        context.move(to: CGPoint(x: w, y: 0))
        //画线
        context.addLine(to: CGPoint(x: w, y:h1))
        context.addLine(to: CGPoint(x: 0, y:h1))
        context.addLine(to: CGPoint(x: 0, y:0))
        context.addQuadCurve(to: CGPoint(x: w, y:0), control: CGPoint(x: w*0.5, y:h + (h - h1) * 0.6))
        //闭合
        context.closePath()
        context.drawPath(using: CGPathDrawingMode.fill)
        
    }
    func drawC(in rect: CGRect){
        //获取上下文
        //CGContextRef 用来保存图形信息.输出目标
        //        let context = UIGraphicsGetCurrentContext()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //设置颜色
        context.setFillColor(red: 0.00392, green: 0.54117, blue: 0.85098, alpha: 1.0)
        
        
        let h1:CGFloat  = self.headerViewHeight;
        let w:CGFloat  = rect.size.width;
        let h:CGFloat  = rect.size.height;
        
        //起点
        context.move(to: CGPoint(x: w, y: h1))
        //画线
        context.addLine(to: CGPoint(x: w, y:h1*0.9))
        context.addQuadCurve(to: CGPoint(x: 0, y:h1*0.9), control: CGPoint(x: w*0.5, y:10))
        context.addLine(to: CGPoint(x: 0, y:h1))
        context.addQuadCurve(to: CGPoint(x: w, y:h1), control: CGPoint(x: w*0.5, y:h + (h - h1) * 0.6))
        //闭合
        context.closePath()
        context.drawPath(using: CGPathDrawingMode.fill)
        
    }
    func drawD(in rect: CGRect){
        //获取上下文
        //CGContextRef 用来保存图形信息.输出目标
//        let context = UIGraphicsGetCurrentContext()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //设置颜色
        context.setFillColor(red: 0.00392, green: 0.54117, blue: 0.85098, alpha: 1.0)

        
        let h1:CGFloat  = self.headerViewHeight;
        let w:CGFloat  = rect.size.width;
        let h:CGFloat  = rect.size.height;
        
        //下拉间距 (h - h1)
        let spacing_Y:CGFloat = (h - h1);
        //修改左右点便移量
        let XYof:CGFloat  = spacing_Y * 0.6;//可修改数字0-1查看效果
        
        let numerical:CGFloat  = 1;//可修改数字0-1查看效果
        //底部偏移
        let bottom_spacing_Y:CGFloat  = spacing_Y * numerical;
        
        //起点
        context.move(to: CGPoint(x: w, y: h1+bottom_spacing_Y))
        //画线
        context.addLine(to: CGPoint(x: w, y:XYof))
        context.addQuadCurve(to: CGPoint(x: 0, y:XYof), control: CGPoint(x: w*0.5, y:0))
        context.addLine(to: CGPoint(x: 0, y:h1 + bottom_spacing_Y))
        context.addLine(to: CGPoint(x: w, y:h1 + bottom_spacing_Y))
        //闭合
        context.closePath()
        context.drawPath(using: CGPathDrawingMode.fill)
        
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 判断点击的点，在不在圆内
        let center:CGPoint = self.loadImage.center;
        let r:CGFloat = self.loadImage.frame.size.width * 0.5;
        let newR: CGFloat  = sqrt((center.x - point.x) * (center.x - point.x) + (center.y - point.y) * (center.y - point.y));
        // 浮点数比较不推荐用等号，虽然 ios 底层已经处理了这种情况
        if (newR > r) {
            return false;
        } else {
            return true;
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
