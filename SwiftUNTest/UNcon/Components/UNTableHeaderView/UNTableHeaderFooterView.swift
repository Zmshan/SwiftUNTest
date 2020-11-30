//
//  UNTableHeaderFooterView.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/13.
//

import UIKit
typealias tabHeadOrFootBlock = (_ paramOne : String? ) -> ()

class UNTableHeaderFooterView: UITableViewHeaderFooterView ,UIGestureRecognizerDelegate{
    var headOrFootBlock: tabHeadOrFootBlock?
    var headIsOpen:Bool = false
     
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.red
        self.loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        NSLog("contentView%f==%@",self.contentView.frame.size.width,NSCoder.string(for: self.customContentView.frame));
    }
    
    
    @objc func loadUI(){
        self.contentView.addSubview(self.customContentView)
        self.customContentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        self.customContentView.addSubview(self.leftText)
        self.leftText.snp_makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(self.customContentView.snp_centerY)
        }
        self.contentView.addSubview(rightView)
        rightView.snp_makeConstraints { (make) in
            make.right.equalTo(self.customContentView.snp_right).offset(-16);
            make.centerY.equalTo(self.customContentView.snp_centerY)
        }
        rightView.addSubview(rightText)
        rightText.snp_makeConstraints { (make) in
            make.top.equalTo(rightView.snp_top).offset(10)
            make.left.equalTo(rightView.snp_left).offset(12)
//            make.centerY.equalTo(rightView.snp_centerY)
            make.bottom.equalTo(rightView.snp_bottom).offset(-10)
        }
        rightView.addSubview(rightImg)
        rightImg.snp_makeConstraints { (make) in
            make.left.equalTo(rightText.snp_right).offset(12)
            make.right.equalTo(rightView.snp_right).offset(0)
            make.centerY.equalTo(rightView.snp_centerY)
        }

        
    }
    
    
    lazy  var customContentView:UIView = {
                var  view  =  UIView.init()
//                view.backgroundColor = UIColor .purple;
                return view
            }()
    lazy  var leftText:UILabel = {
                var  view  =  UILabel.init()
//                view.backgroundColor = UIColor .purple;
                return view
            }()
    lazy  var rightView:UIView = {
                var  view  =  UIView.init()
        view.isUserInteractionEnabled = true;
//        let tap:UIGestureRecognizer = UIGestureRecognizer.init()
////        tap.numberOfTouches = 1
//        tap.delegate = self
//        tap.addTarget(self, action: #selector(self.disTap))
//        view .addGestureRecognizer(tap);
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewClick))
        view.addGestureRecognizer(singleTapGesture)
        view.isUserInteractionEnabled = true
                view.backgroundColor = UIColor .purple;
                return view
            }()
    lazy  var rightText:UILabel = {
                var  view  =  UILabel.init()
//                view.backgroundColor = UIColor .purple;
                return view
            }()
    lazy  var rightImg:UIImageView = {
                var  view  =  UIImageView.init()
                view.image = UIImage.init(named: "icon_turnhome")
//                view.backgroundColor = UIColor .purple;
                return view
            }()
    
    @objc func rightViewClick(){
          if(headOrFootBlock != nil) {
            headOrFootBlock!("headOrFootBlock的值")
            }
        }
    func headOrFootBlockFunction ( block: @escaping (_ paramOne : String? ) -> () ) {
        headOrFootBlock = block
       }
    func isOPenFunction (isOpen:Bool){
        print("didSetisOpen5")
        if(isOpen == false){
            leftText.text = "我要改变"
            headIsOpen = true
            rightText.snp_updateConstraints { (make) in
                make.top.equalTo(rightView.snp_top).offset(30)
                make.bottom.equalTo(rightView.snp_bottom).offset(-30)
            }
        }else{
            leftText.text = "最新资讯";
            headIsOpen = false
            rightText.snp_updateConstraints { (make) in
                make.top.equalTo(rightView.snp_top).offset(10)
                make.bottom.equalTo(rightView.snp_bottom).offset(-10)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
