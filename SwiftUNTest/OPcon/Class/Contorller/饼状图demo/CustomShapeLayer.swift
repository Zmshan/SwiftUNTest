//
//  CustomShapeLayer.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/30.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit

class CustomShapeLayer: CAShapeLayer {
    var startAngle = CGFloat()//起始弧度
    var endAngle = CGFloat()//结束弧度
    var radius = CGFloat()//圆饼半径
    var clickOffset = CGFloat()//点击偏移量
    var isSelected = Bool()//是否点击
    var isOneSection = Bool()//是否只有一个模块，多个模块的动画与单个模块的动画不一样
    var centerPoint = CGPoint()//圆饼layer的圆心
    var innerRadius = CGFloat()//内圆半径
    var innerColor = UIColor()//内圆颜色
    
    
    //    var isSelected:Bool?{
    //        didSet
    //        {
    //            print("did set ",isSelected!)
    //            self.setIsSelected(isSelected: isSelected!)
    //        }
    //    }
    
    
    func setIsSelected(isSelected:Bool) -> Void {
        self.isSelected = isSelected
        var newCenterPoint:CGPoint = self.centerPoint
        let offset:CGFloat = self.preferGetUserSetValue(userValue: self.clickOffset, defaultValue: 15)
        if self.isOneSection{
            self.dealOneSectionWithSelected(isSelected: isSelected, offset: offset)
            return
        }
        
        if isSelected{
            //center 往外围移动一点 使用cosf跟sinf函数
            newCenterPoint =  CGPoint(x: self.centerPoint.x + CGFloat(cosf(Float((self.startAngle + self.endAngle) / 2)))*offset, y:  self.centerPoint.y + CGFloat(sinf(Float((self.startAngle + self.endAngle) / 2)))*offset)
            
        }
        
        //创建一个path
        let path = UIBezierPath()
        //起始中心点改一下
        path.move(to: newCenterPoint)
        path.addArc(withCenter: newCenterPoint, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        path.addArc(withCenter: newCenterPoint, radius: self.innerRadius, startAngle: self.endAngle, endAngle: self.startAngle, clockwise: false)
        path.close()
        
        self.path = path.cgPath
        //添加动画
        let animation = CABasicAnimation()
        //keyPath内容是对象的哪个属性需要动画
        animation.keyPath = "path"
        //所改变属性的结束时的值
        animation.toValue = path
        //动画时长
        animation.duration = 0.35
        //添加动画
        self.add(animation, forKey: nil)
        
    }
    
    //单个圆饼的处理
    func dealOneSectionWithSelected(isSelected:Bool,offset:CGFloat) -> Void {
        
        
        //创建一个path
        let originPath = UIBezierPath()
        //起始中心点改一下
        originPath.move(to: self.centerPoint)
        originPath.addArc(withCenter: self.centerPoint, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        originPath.addArc(withCenter: self.centerPoint, radius: self.innerRadius, startAngle: self.endAngle, endAngle: self.startAngle, clockwise: false)
        originPath.close()
        
        
        //创建一个path
        let path = UIBezierPath()
        //起始中心点改一下
        path.move(to: self.centerPoint)
        path.addArc(withCenter: self.centerPoint, radius: self.radius+offset, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        path.addArc(withCenter: self.centerPoint, radius: self.innerRadius, startAngle: self.endAngle, endAngle: self.startAngle, clockwise: false)
        path.close()
        
        if !isSelected {
            self.path = originPath.cgPath
            //添加动画
            let animation = CABasicAnimation()
            //keyPath内容是对象的哪个属性需要动画
            animation.keyPath = "path"
            animation.fromValue = path
            //所改变属性的结束时的值
            animation.toValue = originPath
            //动画时长
            animation.duration = 0.35
            //添加动画
            self.add(animation, forKey: nil)
        }else{
            self.path = originPath.cgPath
            //添加动画
            let animation = CABasicAnimation()
            //keyPath内容是对象的哪个属性需要动画
            animation.keyPath = "path"
            animation.fromValue = originPath
            //所改变属性的结束时的值
            animation.toValue = path
            //动画时长
            animation.duration = 0.35
            //添加动画
            self.add(animation, forKey: nil)
        }
        
    }
    
    
    func preferGetUserSetValue(userValue:CGFloat, defaultValue:CGFloat) -> CGFloat {
        if userValue>0 {
            return userValue
        }else{
            return defaultValue;
        }
    }
    
    
}
