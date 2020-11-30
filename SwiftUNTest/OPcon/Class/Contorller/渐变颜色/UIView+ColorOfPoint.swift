//
//  UIView+ColorOfPoint.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/26.
//  Copyright © 2019  open-roc. All rights reserved.
//

import Foundation
import UIKit
var Red = CGFloat()
var Green = CGFloat()
var Blue = CGFloat()
extension UIView{
   
   
    
func colorOfPoint(point:CGPoint) -> UIColor {
   
    let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
    context?.translateBy(x: -point.x, y:  -point.y)
    self.layer.render(in: context ?? 0 as! CGContext)
    Red = CGFloat(Float(pixel [0]) / 255.0)
    Green = CGFloat(Float(pixel [1]) / 255.0)
    Blue = CGFloat(Float(pixel [2]) / 255.0)
    let color:UIColor = UIColor.init(red: CGFloat(Float(pixel [0]) / 255.0), green: CGFloat(Float (pixel [1]) / 255.0), blue: CGFloat(Float (pixel [2]) / 255.0) , alpha: CGFloat(Float (pixel [3]) / 255.0))
    
   return color
    
//    var pixel : [UInt8] = [0, 0, 0, 0]
//    var colorSpace = CGColorSpaceCreateDeviceRGB()
//    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//    let context = CGBitmapContextCreate(UnsafeMutablePointer(pixel), 1, 1, 8, 4, colorSpace, bitmapInfo)
}
    
    func getRed() -> CGFloat {
        
        return Red*255
    }
    func getGreen() -> CGFloat {
        
        return Green*255
    }
    func getBlue() -> CGFloat {
        
        return Blue*255
    }

}

