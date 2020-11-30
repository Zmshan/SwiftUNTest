//
//  CustomTabBar.swift
//  TestSwift
//
//  Created by open-roc on 2018/9/10.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WHITECOLOR;
//        if #available(iOS 13.0, *) {
            self.setUpAllChildViewController();
//        } else {
//            // Fallback on earlier versions
//            self.setLowUpAllChildViewController();
//        }
        
        // Do any additional setup after loading the view.
    }
    func setLowUpAllChildViewController(){
        var homeImage  = ""
        var unHomeImage = ""
        
        var personalImage = ""
        var unPersonalImage = ""
        
        var centerImage = ""
        var unCenterImage = ""
        
        var courseImage = ""
        var unCourseImage = ""
        
        var gongnegImage = ""
        var unGongnegImage = ""
        
        
        
        homeImage += "hover";
        unHomeImage += "unhover";
        
        courseImage += "icon_book_p";
        unCourseImage += "icon_book_n";
        
        
        centerImage += "icon_continue";
        unCenterImage += "icon_continue";
        
        gongnegImage += "icon_function_p";
        unGongnegImage += "icon_function_n";
        
        personalImage += "uesrhover";
        unPersonalImage += "unuesrhover";
//        self.tabBar.backgroundImage = imageWithColor(color: WHITECOLOR)
        let home = HomeViewController.init()
    
        self.setLowUpOneChildViewController(viewController: home, selectedImage:(UIImage.init(named: homeImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unHomeImage)?.withRenderingMode(.alwaysOriginal))!, title: "首页", itemTag: 0)
        
        let classification = TPClassificationCourseViewController.init()
        
        self.setLowUpOneChildViewController(viewController: classification, selectedImage:(UIImage.init(named: courseImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unCourseImage)?.withRenderingMode(.alwaysOriginal))!, title: "课程分类", itemTag: 0)
        
        
        let learning = LearningTheCourseViewController.init()
        
        self.setLowUpOneChildViewController(viewController: learning, selectedImage:(UIImage.init(named: centerImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: centerImage)?.withRenderingMode(.alwaysOriginal))!, title: "", itemTag: 0)
        
        
        let function = FunctionViewController.init()
        
        self.setLowUpOneChildViewController(viewController: function, selectedImage:(UIImage.init(named: gongnegImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unGongnegImage)?.withRenderingMode(.alwaysOriginal))!, title: "功能", itemTag: 0)
        
        
        let MeVc = MeViewController.init()
        
        self.setLowUpOneChildViewController(viewController: MeVc, selectedImage:(UIImage.init(named: personalImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unPersonalImage)?.withRenderingMode(.alwaysOriginal))!, title: "我的", itemTag: 0)
        
        
    
    }
    func setLowUpOneChildViewController(viewController:UIViewController,selectedImage:UIImage,unSelectedImage:UIImage,title:NSString,itemTag:NSInteger){
        
        let nav = CustomNavigationViewController.init(rootViewController: viewController)
        nav.tabBarItem = UITabBarItem.init(title: title as String, image: unSelectedImage, selectedImage: selectedImage)
        nav.tabBarItem.tag = itemTag;
        nav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        nav.tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.orange], for: UIControl.State.normal)
        nav.tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.blue], for: UIControl.State.selected)
        self.addChild(nav)
        
    }
    
    
    func setUpAllChildViewController(){
        var homeImage  = ""
        var unHomeImage = ""
        
        var personalImage = ""
        var unPersonalImage = ""
        
        var centerImage = ""
        var unCenterImage = ""
        
        var courseImage = ""
        var unCourseImage = ""
        
        var gongnegImage = ""
        var unGongnegImage = ""
        
        
        
        homeImage += "hover";
        unHomeImage += "unhover";
        
        courseImage += "icon_book_p";
        unCourseImage += "icon_book_n";
        
        
        centerImage += "icon_continue";
        unCenterImage += "icon_continue";
        
        gongnegImage += "icon_function_p";
        unGongnegImage += "icon_function_n";
        
        personalImage += "uesrhover";
        unPersonalImage += "unuesrhover";
//        self.tabBar.backgroundImage = imageWithColor(color: WHITECOLOR)
        
       
        
        let home = HomeViewController.init()
    
        self.setUpOneChildViewController(viewController: home, selectedImage:(UIImage.init(named: homeImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unHomeImage)?.withRenderingMode(.alwaysOriginal))!, title: "首页", itemTag: 0)
        
        let classification = TPClassificationCourseViewController.init()
        
        self.setUpOneChildViewController(viewController: classification, selectedImage:(UIImage.init(named: courseImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unCourseImage)?.withRenderingMode(.alwaysOriginal))!, title: "课程分类", itemTag: 0)
        
        
        let learning = LearningTheCourseViewController.init()
        
        self.setUpOneChildViewController(viewController: learning, selectedImage:(UIImage.init(named: centerImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: centerImage)?.withRenderingMode(.alwaysOriginal))!, title: "", itemTag: 0)
        
        
        let function = FunctionViewController.init()
        
        self.setUpOneChildViewController(viewController: function, selectedImage:(UIImage.init(named: gongnegImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unGongnegImage)?.withRenderingMode(.alwaysOriginal))!, title: "功能", itemTag: 0)
        
        
        let MeVc = MeViewController.init()
        
        self.setUpOneChildViewController(viewController: MeVc, selectedImage:(UIImage.init(named: personalImage)?.withRenderingMode(.alwaysOriginal))!, unSelectedImage: (UIImage.init(named: unPersonalImage)?.withRenderingMode(.alwaysOriginal))!, title: "我的", itemTag: 0)
        
        
    
    }
    func setUpOneChildViewController(viewController:UIViewController,selectedImage:UIImage,unSelectedImage:UIImage,title:NSString,itemTag:NSInteger){
        
        let nav = CustomNavigationViewController.init(rootViewController: viewController)
        nav.tabBarItem = UITabBarItem.init(title: title as String, image: unSelectedImage, selectedImage: selectedImage)
        nav.tabBarItem.tag = itemTag;
        nav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        nav.tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.orange], for: UIControl.State.normal)
        nav.tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.blue], for: UIControl.State.selected)
        self.addChild(nav)
        
    }
    
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
