//
//  ZCAGradientLayerViewController.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/26.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit

class ZCAGradientLayerViewController: UIViewController {
    var colors = NSArray()//渐变颜色数组
    var locations = NSArray()//渐变颜色的区间分布，
    var startPoint = CGFloat()//映射locations中第一个位置，
    //用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)。
    var endPoint = CGFloat()//映射locations中最后一个位置
    //,用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)。
    var loadType = NSInteger()
    var chageViewColor = UIView()
    var changeColorLabel = UILabel()
    var bgImage = UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UIBarButtonItem.init(title: "背景渐变", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ZCAGradientLayerViewController.rightBtn(item:)))
        
        let item1 = UIBarButtonItem.init(title: "图片", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ZCAGradientLayerViewController.rightBtn(item:)))
        self.navigationItem.rightBarButtonItems = [item,item1];
        
        
        self .loadCAGradientLayer()
        
       
        self.bgImage.image = UIImage.init(named: "山水.jpg");
        self.view.addSubview(self.bgImage)
    
        self.chageViewColor.layer.cornerRadius = 50;
        self.chageViewColor.layer.masksToBounds = true;
        self.chageViewColor.backgroundColor = UIColor.lightGray;
        self.view.addSubview(self.chageViewColor)
        
        
        
        
        self.changeColorLabel.textColor = UIColor.black
        self.changeColorLabel.font = UIFont.systemFont(ofSize: 14)
        self.changeColorLabel.textAlignment = NSTextAlignment.center
        self.changeColorLabel.numberOfLines = 0;
        self.view.addSubview(self.changeColorLabel)
       
        
       
        
        
        
        self.bgImage.isHidden = true;
        self.bgImage .snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.chageViewColor .snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.width.height.equalTo(100);
        }
        
        self.changeColorLabel .snp.makeConstraints { (make) in
            make.bottom.equalTo(self.chageViewColor.snp_top).offset(-10);
            make.centerX.equalTo(self.chageViewColor);
        }
       

    }
    

    @objc func rightBtn(item :UIBarButtonItem){
        if item.title == "背景渐变"{
            self.loadType = 0;
            self.bgImage.isHidden = true;
        }else{
            self.loadType = 1;
            self.bgImage.isHidden = false;
        }
    }
    
    
    
    
    
    
    
    func loadCAGradientLayer() -> Void {
        //渐变色
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        self.view.layer .addSublayer(gradientLayer)
        
        let R:CGFloat = CGFloat(arc4random()%255);
        let G:CGFloat = CGFloat(arc4random()%255);
        let B:CGFloat = CGFloat(arc4random()%255);
        
        let lightColor:UIColor = UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
        
        let whiteColor:UIColor = UIColor.init(red: 255.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        //可以设置多个colors,
        gradientLayer.colors = [lightColor.cgColor,whiteColor.cgColor];
        //45度变色(由lightColor－>white)
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
        
        
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         guard let point = touches.first?.location(in: view) else { return }
        
        
        if self.loadType==0 {
            
            self.chageViewColor.backgroundColor = self.view.colorOfPoint(point: point);
//            let components[3] = CGFloat()
            self.changeColorLabel.text = NSString( format: "red:%f\ngreen:%f\nblue:%f", self.view.getRed(),self.view.getGreen(),self.view.getBlue() ) as String
            
            
        }else{
            
            
             self.chageViewColor.backgroundColor = self.bgImage.colorOfPoint(point: point);
            self.changeColorLabel.text = NSString( format: "red:%f\ngreen:%f\nblue:%f", self.bgImage.getRed(),self.bgImage.getGreen(),self.bgImage.getBlue() ) as String
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }
        if self.loadType==0 {
             self.chageViewColor.backgroundColor = self.view.colorOfPoint(point: point);
            self.changeColorLabel.text = NSString( format: "red:%f\ngreen:%f\nblue:%f", self.view.getRed(),self.view.getGreen(),self.view.getBlue() ) as String
        }else{
            
             self.chageViewColor.backgroundColor = self.bgImage.colorOfPoint(point: point);
            self.changeColorLabel.text = NSString( format: "red:%f\ngreen:%f\nblue:%f", self.bgImage.getRed(),self.bgImage.getGreen(),self.bgImage.getBlue() ) as String
        }
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
