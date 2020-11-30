//
//  File.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import Foundation
import UIKit
func imageWithColor(color:UIColor) -> UIImage {
    
    let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color as! CGColor);
    context!.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image!;
}
extension UIImage{
    
    /**
     根据坐标获取图片中的像素颜色值
     */
    subscript (x: Int, y: Int) -> UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
        
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
