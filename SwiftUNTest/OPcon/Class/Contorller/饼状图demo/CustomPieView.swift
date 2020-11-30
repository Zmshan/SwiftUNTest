//
//  CustomPieView.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/27.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit


//typealias ZClickBlock = (_ idnex:NSInteger) -> Void
typealias ZClickBlock = (NSInteger) -> Void
enum PieAnimationType:Int {
    case  PieAnimationTypeOne = 0//所有部分只有一个动画
    case  PieAnimationTypeTogether//所有部分一起动画
}
enum PieCenterType:Int {
    case  PieCenterTypeCenter = 0   //默认，圆心位于视图的中心
    case  PieCenterTypeTopLeft      //圆位于视图的上部的左侧
    case  PieCenterTypeTopMiddle    //圆位于视图的上部的中间
    case  PieCenterTypeTopRight     //圆位于视图的上部的右侧
    case  PieCenterTypeMiddleLeft   //圆位于视图的中部的左侧
    case  PieCenterTypeMiddleRight  //圆位于视图的中部的右侧
    case  PieCenterTypeBottomLeft   //圆位于视图的底部的左侧
    case  PieCenterTypeBottomMiddle //圆位于视图的底部的中间
    case  PieCenterTypeBottomRight  //圆位于视图的底部的右侧
}

class CustomPieView: UIView {
    var segmentDataArray = NSArray()//饼状图数据数组
    var segmentTitleArray = NSArray()//饼状图标题数组
    var segmentColorArray = NSArray()//饼状图颜色数组
    var pieRadius = CGFloat()//圆饼的半径
    var needAnimation = Bool()//是否动画
    var hideText = Bool()//是否隐藏文本
    var animateTime = CGFloat()//动画时间
    var type = PieAnimationType(rawValue: 0)//动画类型,默认只有一个动画
    var innerCircleR = CGFloat()//内部圆的半径，默认大圆半径的1/3
    var innerColor = UIColor()//内部圆的颜色，默认白色
    var centerType = PieCenterType(rawValue: 0)//圆的位置，默认视图的中心
    var textRightSpace = CGFloat()//右侧文本 距离右侧的间距
    var centerXPosition = CGFloat()//圆心的X位置
    var centerYPosition = CGFloat()//圆心的Y位置
    var textHeight = CGFloat()//文本的高度，默认20
    var colorHeight = CGFloat()//文本前的颜色模块的高度，默认等同于文本高度
    var textFontSize = CGFloat()//文本的字号，默认14
    var textSpace = CGFloat()// 文本的行间距，默认10
    var isRound = Bool()//文本前的颜色是否为圆
    var isSameColor = Bool()//是否文本颜色等于模块颜色,默认不一样，文本默认黑色
    var canClick = Bool()//是否允许点击
    var clickOffsetSpace = CGFloat()// 点击偏移量，默认15
    var selectedIndex = NSInteger()// 选中的index，不设置的话，没有选中的模块
    
   
    
    private var realRadius = CGFloat() //饼状图的实际半径
    private var pieShapeLayerArray = NSMutableArray()//饼状图 array
    private var segmentCoverLayerArray = NSMutableArray()//各个部分的coverLayer
    private var segmentPathArray = NSMutableArray()//各个部分的path
    private var pieR = CGFloat() //半径
    private var pieCenter = CGPoint() //圆心
    private var whiteLayer = CAShapeLayer() //内部的小圆
    
    private var coverCircleLayer = CAShapeLayer() //
    private var finalTextArray = NSMutableArray()//最终的文本数组
    private var colorRightOriginPoint = CGPoint()// 颜色块的位置
    private var realTextFont = CGFloat()//实际的文本字号
    private var realTextHeight = CGFloat() //实际的文本高度
    private var realTextSpace = CGFloat() //实际的文本间距
    private var colorPointArray = NSMutableArray() //小圆点数组
//    private var clickBlock:ZClickBlock?//点击圆饼的index的block
    private var clickBlock:ZClickBlock!//点击圆饼的index的block
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        if !self.hideText {
            self.drawRightText()
        }
    }
//    MARK:绘制右侧的文本
    func drawRightText() -> Void {
        
        let  viewWidth:CGFloat = self.bounds.size.width;
        let colorHeight:CGFloat = self.preferGetUserSetValue(userValue: self.colorHeight, defaultValue: self.realTextHeight)
        let textX:CGFloat = self.colorRightOriginPoint.x+colorHeight;//文本前面有一个颜色方块／圆
        let textY:CGFloat = self.colorRightOriginPoint.y;
        
        let attrs = NSMutableDictionary()
        
        
//        self.finalTextArray .enumerateObjects { (obj, index, stop) in
//        }
        
        for index in 0..<self.finalTextArray.count{
            
            let content:NSString = self.finalTextArray[index] as! NSString;
            var textColor = UIColor.black
            
            if self.isSameColor {
                if index < self.segmentColorArray.count {
                    textColor = self.segmentColorArray[index] as! UIColor;
                }
            }
            let textUseHeight:CGFloat = self.heightForTextString(vauleString: content, textWidth: 1000, textSize: self.realTextFont)
            
            let textOffset:CGFloat = (self.realTextHeight - textUseHeight)/2
        
            attrs[NSAttributedString.Key.foregroundColor] = textColor;
            attrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: self.realTextFont)
        
            let tag:CGFloat = 1000
            print("sqrt(tag)===%f",sqrt(tag))
            
            content.draw(in: CGRect(x: textX, y: textY+self.realTextSpace*CGFloat(index)+self.realTextHeight*CGFloat(index)+textOffset, width: viewWidth-textX, height: self.realTextHeight), withAttributes: attrs as? [NSAttributedString.Key : Any])

            
        }
    }
       
        
    func updatePieView() -> Void {
        
        whiteLayer.removeFromSuperlayer()
        
        
        for layerA in pieShapeLayerArray {
//            layerA = layerA as! CAShapeLayer
//            var layer = CAShapeLayer()
//            layer = layerA as! CAShapeLayer
            (layerA as AnyObject).removeFromSuperlayer()
        }
        
        for layerA in colorPointArray {
//            var layer = CAShapeLayer()
//            layer = layerA as! CAShapeLayer
//            layer .removeFromSuperlayer()
            (layerA as AnyObject).removeFromSuperlayer()
        }
        
        self.colorPointArray.removeAllObjects()
        pieShapeLayerArray.removeAllObjects()
        segmentPathArray.removeAllObjects()
        segmentCoverLayerArray.removeAllObjects()
        self.setNeedsDisplay()
        
    
        
        if !self.needAnimation {
            self.loadNoAnimation()
            
            return;
        }
        
        if (self.type == .PieAnimationTypeTogether) {
            self.loadTogetherAnimation()
            
        }else{
            self.loadNoAnimation()
        }
    }
    
    
    func showCustomViewInSuperView(superView:UIView) -> Void {
        
        pieShapeLayerArray = NSMutableArray()
        segmentPathArray = NSMutableArray()
        segmentCoverLayerArray = NSMutableArray()
        self.colorPointArray = NSMutableArray()
        
        if self.segmentColorArray.count==0 {
            self.segmentColorArray = self.loadRandomColorArray()
        }
       
        superView.addSubview(self)
      
        if !self.needAnimation {
            self.loadNoAnimation()
            return;
        }
        if self.type == .PieAnimationTypeTogether {
            self.loadTogetherAnimation()
        }else{
            self.loadOneAnimation()
        }
    
    }
    
    // 单个动画的饼状图
    func loadOneAnimation() -> Void {
        if !self.hideText {
            self.loadTextContent()
            
        }
        self.loadPieView()
        self.doSegmentAnimation()
        
    }
    //同时动画的饼状图
    func loadTogetherAnimation() -> Void {
        if !self.hideText {
            self.loadTextContent()
         
        }
        self.loadCustomPieView()
        self.doSegmentAnimation()
    }
    //无动画的饼状图
    func loadNoAnimation() -> Void {
        self.loadTextContent()
        self.loadPieView()
        
    }
    //加载文本并调整饼状图中心
    func loadTextContent() -> Void {
        self.loadFinalText()
        self.centerType = .PieCenterTypeMiddleLeft
        self.loadRightTextAndColor()
    }
    //处理展示的文本
    func loadFinalText() -> Void {
        self.realTextHeight = self.preferGetUserSetValue(userValue: self.textHeight, defaultValue: 20)
        self.realTextFont = self.preferGetUserSetValue(userValue: self.textFontSize, defaultValue: 14)
        self.realTextSpace = self.preferGetUserSetValue(userValue: self.textSpace, defaultValue: 10)
        
        //数据总值
        var totalValue:CGFloat = 0
        var valueString =  NSString()
        
        for valueStr  in self.segmentDataArray {
            valueString = valueStr as! NSString
            totalValue += CGFloat(valueString.floatValue);
            
        }
       self.finalTextArray = NSMutableArray()
        for i in 0..<self.segmentDataArray.count{
            //数据文本
            let valueString:NSString = self.segmentDataArray[i] as! NSString
            
            //数据值
            let value:CGFloat = CGFloat(valueString.floatValue)
            
            //当前数值的占比
            let rate:CGFloat = value/totalValue
            var titleString:NSString = "其他"
            

            if i < self.segmentTitleArray.count{
                titleString = self.segmentTitleArray[i] as! NSString;
            }
            
            let finalString:NSString = NSString(format: " %@:%.1f %.1f％",titleString,value,rate*100)
            
            self.finalTextArray.add(finalString)
           
        }
      
    }
    //计算右侧显示文本的frame
    func loadRightTextAndColor() -> Void {
        let viewHeight:CGFloat = self.bounds.size.height
        let viewWidth:CGFloat = self.bounds.size.width
        
        
        var maxWidth:CGFloat = 0
        
        
        for i in 0..<self.finalTextArray.count{
            //文本
            let valueString:NSString = self.finalTextArray[i] as! NSString
            
            let finalWidth:CGFloat = self.widthForTextString(tStr: valueString, tHeight: self.realTextHeight, tSize: self.realTextFont)
            
            
            if finalWidth > maxWidth {
                
                maxWidth = finalWidth;
            }
        }
        
        let colorHeight:CGFloat = self.preferGetUserSetValue(userValue: self.colorHeight, defaultValue: self.realTextHeight)
        
        let textRightSpace:CGFloat = self.preferGetUserSetValue(userValue: self.textRightSpace, defaultValue: 0)
        
        let colorOriginX:CGFloat = viewWidth - maxWidth - colorHeight - textRightSpace
        
        let colorOriginY:CGFloat = (viewHeight-(self.realTextHeight*CGFloat(self.finalTextArray.count)+self.realTextSpace*CGFloat(self.finalTextArray.count-1))) / CGFloat(2)
        
        self.colorRightOriginPoint = CGPoint(x: colorOriginX, y: colorOriginY)
        
        print("colorRightOriginPoint",self.colorRightOriginPoint)
        for i in 0..<self.finalTextArray.count{
            //颜色方块
            let colorLayer = CAShapeLayer()
            let spaceHeight:CGFloat =  (self.realTextHeight-colorHeight)/2;
            
            
            colorLayer.frame = CGRect(x: colorOriginX, y: colorOriginY + self.realTextSpace * CGFloat(i) + self.realTextHeight*CGFloat(i) + spaceHeight,width: colorHeight,height: colorHeight);
            
            var segColor = UIColor.cyan
            
            if i < self.segmentColorArray.count {
                
                segColor = self.segmentColorArray[i] as! UIColor;
            }
            
            colorLayer.backgroundColor = segColor.cgColor;
            
            
            if self.isRound {
                
                colorLayer.cornerRadius = colorHeight/2;
            }
            self.colorPointArray.add(colorLayer)
            self.layer.addSublayer(colorLayer)
            
        }
    }
    func widthForTextString(tStr:NSString,tHeight:CGFloat,tSize:CGFloat)-> CGFloat {
        
        let dict:NSDictionary = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: tSize)]
        
        let rect:CGRect = tStr.boundingRect(with: CGSize(width:CGFloat(MAXFLOAT),height: tHeight), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.truncatesLastVisibleLine.rawValue), attributes: dict as? [NSAttributedString.Key : Any], context: nil)
        
        return rect.size.width + CGFloat(5)
        
    }
    
    
    //计算label的高度
    func heightForTextString(vauleString:NSString,textWidth:CGFloat,textSize:CGFloat) -> CGFloat {
        let dict:NSDictionary = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: textSize)]
        
        
        let rect:CGRect = vauleString.boundingRect(with: CGSize(width:textWidth,height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.truncatesLastVisibleLine.rawValue), attributes: dict as? [NSAttributedString.Key : Any], context: nil)
        
        
        return rect.size.height ;
    }
    
    //加载同时动画的饼状图
    func loadCustomPieView() -> Void {
        //半径
        pieR = self.preferGetUserSettingRadiusValue()
        
        //圆心
        self.loadPieCenter()
        
        if (self.centerXPosition > 0  ) {
            pieCenter = CGPoint(x: self.centerXPosition, y: pieCenter.y)
        }
        
        if (self.centerYPosition > 0 ) {
            pieCenter = CGPoint(x: pieCenter.x, y: self.centerYPosition)
            
        }
        
        //数据总值
        var totalValue:CGFloat = 0
        
        //当前开始的弧度,这里初始的角度要和self.coverCircleLayer遮罩的初始角度一致，否则，颜色模块会被分割开
        var currentRadian:CGFloat = CGFloat(-Double.pi/2);
        
        
        
        for valueString in self.segmentDataArray {
            var valueStrings = NSString()
            valueStrings = valueString as! NSString
            totalValue = totalValue + CGFloat(valueStrings.floatValue);
        }
        
        let offset:CGFloat = self.preferGetUserSetValue(userValue: self.clickOffsetSpace, defaultValue: 15)
        let innerWhiteRadius:CGFloat = self.preferGetUserSetInnerRadiusValue(userValue: self.innerCircleR, defaultValue: pieR/3)
        let innerColor:UIColor = self.preferGetUserSetColor(userColor: self.innerColor, defaultColor: UIColor.white)
        
        for i in 0..<self.segmentDataArray.count{
            
            
            //数据文本
            let valueString:NSString = self.segmentDataArray[i] as! NSString
            
            //数据值
            let value:CGFloat = CGFloat(valueString.floatValue)
            
            
            
            //根据当前数值的占比，计算得到当前的弧度
            let radian:CGFloat = self.loadPercentRadianWithCurrent(current: value, total: totalValue)
        
            //弧度结束值 初始值＋当前弧度
    
            let endAngle:CGFloat = currentRadian + radian
            
            //贝塞尔曲线
            let path = UIBezierPath()
            path.move(to: pieCenter)
        
            //圆弧 默认最右端为0，YES时为顺时针。NO时为逆时针。
            path.addArc(withCenter: pieCenter, radius: pieR, startAngle: currentRadian, endAngle: endAngle, clockwise: true)
            
            path.addArc(withCenter: pieCenter, radius: innerWhiteRadius, startAngle: endAngle, endAngle: currentRadian, clockwise: false)
            
            
            //添加到圆心直线
            path.addLine(to: pieCenter)
            
            //路径闭合
            path.close()
            
            //当前shapeLayer的遮罩
            let coverPath = UIBezierPath()
            coverPath.addArc(withCenter: pieCenter, radius: pieR/2+offset, startAngle: currentRadian, endAngle: endAngle, clockwise: true)
            segmentPathArray.add(coverPath)
            
            //初始化Layer
            let radiusLayer = CustomShapeLayer()
        
            //设置layer的路径
            radiusLayer.centerPoint = pieCenter;
            radiusLayer.startAngle = currentRadian;
            radiusLayer.endAngle = endAngle;
            radiusLayer.radius = pieR;
            radiusLayer.innerColor = innerColor;
            radiusLayer.innerRadius = innerWhiteRadius;
            radiusLayer.path = path.cgPath;
            
            //下一个弧度开始位置为当前弧度的结束位置
            currentRadian = endAngle;
            
            
            //默认cyan颜色
            var currentColor = UIColor.cyan

            if (i < self.segmentColorArray.count) {
                
                currentColor = self.segmentColorArray[i] as! UIColor;
            }
            radiusLayer.fillColor = currentColor.cgColor
            pieShapeLayerArray.add(radiusLayer)
            self.layer.addSublayer(radiusLayer)
        
        }
        
        
        
        for i in 0..<segmentPathArray.count{
            let path:UIBezierPath = segmentPathArray[i] as! UIBezierPath
            let originLayer:CAShapeLayer = pieShapeLayerArray[i] as! CAShapeLayer
            let layer = CAShapeLayer()
            
            layer.lineWidth = pieR+offset*2;
            layer.strokeStart = 0;
            layer.strokeEnd = 0;
            layer.strokeColor = UIColor.black.cgColor;
            layer.fillColor = UIColor.clear.cgColor;
            layer.path = path.cgPath;
            originLayer.mask = layer;
            segmentCoverLayerArray.add(layer)
        }
        
        
        let whitePath = UIBezierPath()
        whitePath.addArc(withCenter: pieCenter, radius: innerWhiteRadius, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
      
        whiteLayer = CAShapeLayer();
        whiteLayer.path = whitePath.cgPath;
        whiteLayer.fillColor = innerColor.cgColor;
        self.layer.addSublayer(whiteLayer)
    }
    
    func doSegmentAnimation() -> Void {
        for layer in segmentCoverLayerArray{
            self.doCustomAnimationWithLayer(layer: layer as! CAShapeLayer)
        }
    }
    
    func doCustomAnimationWithLayer(layer:CAShapeLayer) -> Void {
        let strokeAnimation = CABasicAnimation()
        strokeAnimation.keyPath = "strokeEnd"
        strokeAnimation.fromValue = (0);
        if (self.animateTime > 0 ) {
            strokeAnimation.duration = CFTimeInterval(self.animateTime);
            
        }else{
            strokeAnimation.duration = 4;
        }
        
        strokeAnimation.toValue = (1);
        strokeAnimation.autoreverses = false; //有无自动恢复效果
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeAnimation.isRemovedOnCompletion = true;
        layer.add(strokeAnimation, forKey: "strokeEndAnimation")
        layer.strokeEnd = 1;
    }
    // 加载一个动画的饼状图
    func loadPieView() -> Void {
        //放置layer的主layer，如果没有这个layer，那么设置背景色就无效了，因为被mask了。
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.frame = self.bounds;
        self.layer.addSublayer(backgroundLayer)
        
        
        
        //半径
        pieR = self.preferGetUserSettingRadiusValue()
        //圆心
        self.loadPieCenter()
        
        if (self.centerXPosition > 0  ) {
            
            pieCenter = CGPoint(x: self.centerXPosition, y: pieCenter.y);
        }
        
        if (self.centerYPosition > 0 ) {
        
            pieCenter = CGPoint(x: pieCenter.x, y: self.centerYPosition);
        }
        
        
        //数据总值
        var totalValue:CGFloat = 0
        
        //当前开始的弧度,这里初始的角度要和self.coverCircleLayer遮罩的初始角度一致，否则，颜色模块会被分割开
        var currentRadian:CGFloat = CGFloat(-Double.pi/2);
    
        for valueString in self.segmentDataArray {
            var valueStrings = NSString()
            valueStrings = valueString as! NSString
            totalValue = totalValue + CGFloat(valueStrings.floatValue);
        }
        
        let offset:CGFloat = self.preferGetUserSetValue(userValue: self.clickOffsetSpace, defaultValue: 15)
        let innerWhiteRadius:CGFloat = self.preferGetUserSetInnerRadiusValue(userValue: self.innerCircleR, defaultValue: pieR/3)
        let innerColor:UIColor = self.preferGetUserSetColor(userColor: self.innerColor, defaultColor: UIColor.white)
        
        
        
        for i in 0..<self.segmentDataArray.count{
            
            //数据文本
            let valueString:NSString = self.segmentDataArray[i] as! NSString
            
            //数据值
            let value:CGFloat = CGFloat(valueString.floatValue)
            
            
            //根据当前数值的占比，计算得到当前的弧度
            let radian:CGFloat = self.loadPercentRadianWithCurrent(current: value, total: totalValue)
            
            //弧度结束值 初始值＋当前弧度
            
            let endAngle:CGFloat = currentRadian+radian
            
            
            
            //贝塞尔曲线
            let path = UIBezierPath()
            path.move(to: pieCenter)
            //圆弧 默认最右端为0，YES时为顺时针。NO时为逆时针。
            path.addArc(withCenter: pieCenter, radius: pieR, startAngle: currentRadian, endAngle: endAngle, clockwise: true)
             path.addArc(withCenter: pieCenter, radius: innerWhiteRadius, startAngle: endAngle, endAngle: currentRadian, clockwise: false)
            
            //添加到圆心直线
            path.addLine(to: pieCenter)

            //路径闭合
            path.close()
            
            
            //当前shapeLayer的遮罩
            let coverPath = UIBezierPath()
            coverPath.addArc(withCenter: pieCenter, radius: pieR/2+offset, startAngle: currentRadian, endAngle: endAngle, clockwise: true)
            segmentPathArray.add(coverPath)
            
            //初始化Layer
            let radiusLayer = CustomShapeLayer()
            
            //设置layer的路径
            radiusLayer.centerPoint = pieCenter;
            radiusLayer.startAngle = currentRadian;
            radiusLayer.endAngle = endAngle;
            radiusLayer.radius = pieR;
            radiusLayer.innerColor = innerColor;
            radiusLayer.innerRadius = innerWhiteRadius;
            radiusLayer.path = path.cgPath;
            
            //下一个弧度开始位置为当前弧度的结束位置
            currentRadian = endAngle;
            
            
            //默认cyan颜色
            var currentColor = UIColor.cyan
            
            if (i < self.segmentColorArray.count) {
                
                currentColor = self.segmentColorArray[i] as! UIColor;
            }
            radiusLayer.fillColor = currentColor.cgColor
            pieShapeLayerArray.add(radiusLayer)
            backgroundLayer.addSublayer(radiusLayer)
            
        }
        
        
        
        
        
        
        //    CGFloat offset = [self preferGetUserSetValue:self.clickOffsetSpace withDefaultValue:15];
        
        //贝塞尔曲线
        let innerPath = UIBezierPath()
        
        
        //圆弧 默认最右端为0，YES时为顺时针。NO时为逆时针。
        innerPath.addArc(withCenter: pieCenter, radius: pieR/2 + offset, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi*3/2), clockwise: true)
        
        
        //初始化Layer
        self.coverCircleLayer = CAShapeLayer()
        //设置layer的路径
        self.coverCircleLayer.lineWidth = pieR+offset*2;
        self.coverCircleLayer.strokeStart = 0;
        self.coverCircleLayer.strokeEnd = 1;
        //Must 如果stroke没有颜色，那么动画没法进行了
        self.coverCircleLayer.strokeColor = UIColor.black.cgColor;
        //决定内部的圆是否显示,如果clearColor，则不会在动画开始时就有各个颜色的、完整的内圈。
        self.coverCircleLayer.fillColor = UIColor.clear.cgColor;
        self.coverCircleLayer.path = innerPath.cgPath;
        backgroundLayer.mask = self.coverCircleLayer
       
        
        //内圈的小圆
        let whitePath = UIBezierPath()
        whitePath.addArc(withCenter: pieCenter, radius: innerWhiteRadius, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        
      
        whiteLayer = CAShapeLayer();
        whiteLayer.path = whitePath.cgPath;
        whiteLayer.fillColor = innerColor.cgColor;
        self.layer.addSublayer(whiteLayer)
        
    }
    
    
    
    func doCustomAnimation() -> Void {
        
        let strokeAnimation = CABasicAnimation()
        strokeAnimation.keyPath = "strokeEnd"
        strokeAnimation.fromValue = (0);
        
        if (animateTime > 0 ) {
            strokeAnimation.duration = CFTimeInterval(animateTime);
            
        }else{
            strokeAnimation.duration = 4;
        }
        
        strokeAnimation.toValue = (1);
        strokeAnimation.autoreverses = false; //有无自动恢复效果
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    
        strokeAnimation.isRemovedOnCompletion = true;
        coverCircleLayer.add(strokeAnimation, forKey: "strokeEndAnimation")
        coverCircleLayer.strokeEnd = 1;
        
    }
    
    func setSelectedIndex(selectedIndex:NSInteger) -> Void {
        self.selectedIndex = selectedIndex;
        
        if (!self.canClick) {
            return;
        }
        
        if (selectedIndex < pieShapeLayerArray.count) {
            let layer:CustomShapeLayer = pieShapeLayerArray[selectedIndex] as! CustomShapeLayer
            
            layer.setIsSelected(isSelected: true)
            
            self.dealClickCircleWithIndex(index: selectedIndex)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //不能点击则不做处理了
        if (!self.canClick) {
            return;
        }
        for _:AnyObject in touches{
            
            print("查看这里调用了几次")
//            guard let touchPoint:CGPoint = touches.first?.location(in: self) else { return }
//            let touchPoint:CGPoint = (touch as AnyObject).location(in: self)
            
            let touch = touches.first! as UITouch
            var point = touch.location(in: self)
            
            for shapeL in pieShapeLayerArray{
                
                let shapeLayer:CustomShapeLayer = shapeL as! CustomShapeLayer
    
                if self.segmentDataArray.count == 1{
                    shapeLayer.isOneSection = true
                }
                shapeLayer.clickOffset = self.preferGetUserSetValue(userValue: self.clickOffsetSpace, defaultValue: 15)
                
                point = shapeLayer.convert(point, from: self.layer)
                print("查看这里调用了几次shapeLayer==",shapeLayer,point)
                if shapeLayer.path?.contains(point) ?? true {
                    //修改选中状态
                    if (shapeLayer.isSelected) {
                        shapeLayer.setIsSelected(isSelected: false)
                        
                    }else{
                        
                        shapeLayer.setIsSelected(isSelected: true)
                        
                    }
                    let index:NSInteger = pieShapeLayerArray.index(of: shapeLayer)
                    
                    //执行block并开始右侧小圆点动画
                    self.dealClickCircleWithIndex(index: index)
                }else{
    
                    shapeLayer.setIsSelected(isSelected: false)
                }
                
            }
        }
        
        
    }
    
    
    
    func dealClickCircleWithIndex(index:NSInteger) -> Void {
        
//        if let _ = clickBlock{
//            clickBlock(index)
//        }
        if(self.clickBlock != nil) {
            self.clickBlock!(index)
        }
        
        if (index < self.colorPointArray.count) {
            let layer:CAShapeLayer = self.colorPointArray[index] as! CAShapeLayer
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.scale"
            animation.values = [0.9,2.0,1.5,0.7,1.3,1.0]
            animation.calculationMode = CAAnimationCalculationMode.cubic
            animation.duration = 0.8
            layer.add(animation, forKey: "scaleAnimation")
           
        }
    }
  
    
    func clickPieView(clickBlock: @escaping (NSInteger) -> () ){
            self.clickBlock = clickBlock
    }
    func loadPieCenter() -> Void {
        let viewHeight:CGFloat = self.bounds.size.height
        let viewWidth:CGFloat = self.bounds.size.width
        
        //圆心
        pieCenter = CGPoint(x:viewWidth/2, y:viewHeight/2)
        
        
        switch (self.centerType) {
        case .PieCenterTypeCenter?:
        
            //圆心
            self.pieCenter = CGPoint(x:viewWidth/2, y:viewHeight/2)
        break;
        case .PieCenterTypeTopLeft?:
        
            //圆心
            self.pieCenter = CGPoint(x:pieR, y:pieR)
        break;
        case .PieCenterTypeTopMiddle?:
        
            //圆心
            self.pieCenter = CGPoint(x:viewWidth/2, y:pieR)
        break;
        case .PieCenterTypeTopRight?:
        
            //圆心
            self.pieCenter = CGPoint(x: viewWidth-pieR, y:pieR)
        break;
        case .PieCenterTypeMiddleLeft?:
            //圆心
            self.pieCenter = CGPoint(x: pieR, y:viewHeight/2)
            
        break;
        case .PieCenterTypeMiddleRight?:
            //圆心
            self.pieCenter = CGPoint(x: viewWidth-pieR, y:viewHeight/2)
        break;
        case .PieCenterTypeBottomLeft?:
            //圆心
            self.pieCenter = CGPoint(x: pieR, y:viewHeight-pieR)
        break;
        case .PieCenterTypeBottomMiddle?:
            //圆心
            self.pieCenter = CGPoint(x: viewWidth/2, y:viewHeight-pieR)
        break;
        case .PieCenterTypeBottomRight?:
            //圆心

            self.pieCenter = CGPoint(x: viewWidth-pieR, y:viewHeight-pieR)
        break;
        default:
            break;
        }
    }
        
    func loadRandomColorArray() -> NSMutableArray {
        
        let colorArray = NSMutableArray()
        for _ in 0..<self.segmentDataArray.count{
            let color:UIColor = self.loadRandomColor()
            colorArray.add(color)
        }
     
        return colorArray;
    }
   
    func loadRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
        let green:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
        let blue:CGFloat = CGFloat(self.getRandomNumber(from: 1, to: 255))
       
        let color:UIColor = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
      
        return color;
    }
    
    func getRandomNumber(from:Int,to:Int) -> Int {
        let tt:Int = (to - from)
        let myUInt32 = UInt32(tt)
        return (Int)(from + Int((arc4random() % myUInt32)))
    }
    
    //根据百分比 分配弧度
    func loadPercentRadianWithCurrent(current:CGFloat,total:CGFloat) -> CGFloat{
    
        let percent:CGFloat = current/total

        return percent*CGFloat(Double.pi*2);
    }
    
    //优先获取用户设置的圆饼半径
    func preferGetUserSettingRadiusValue() -> CGFloat {
        let viewHeight:CGFloat = self.bounds.size.height
        let viewWidth:CGFloat = self.bounds.size.width

        var minValue:CGFloat = 0
        if viewWidth > viewHeight{
            minValue = viewHeight
        }else{
            minValue = viewWidth
        }
        

        //圆饼的半径
        var pieRadius:CGFloat = 0
        if self.pieRadius > 0 {
            //如果设置了圆饼的半径
            pieRadius = self.pieRadius;
            //如果设置的圆饼半径太大，则取能显示的最大值
            if pieRadius > minValue/2 {
                
                pieRadius = minValue/2;
            }
            
        }else{
            //如果没有设置圆饼的半径
            pieRadius = minValue/2;
        }
        
        return pieRadius;

    }
    
    func preferGetUserSetInnerRadiusValue(userValue:CGFloat,defaultValue:CGFloat) -> CGFloat {
        if (userValue >= 0 ) {
            return userValue;
        }else{
            
            return defaultValue;
        }
    }
    func preferGetUserSetValue(userValue:CGFloat,defaultValue:CGFloat) -> CGFloat {
        if userValue > 0  {
            return userValue;
        }else{
            
            return defaultValue;
        }
    }
    func preferGetUserSetColor(userColor:UIColor,defaultColor:UIColor) -> UIColor {
        
        if userColor .isProxy(){
            return userColor;
        }else{
            return defaultColor;
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
