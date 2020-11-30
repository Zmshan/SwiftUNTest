//
//  UNColumnBtns.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/12.
//

import UIKit
import Kingfisher
enum showStyle:Int {
    case defaultStyle = 0
    case circularStyle = 1
}

//代理方法
protocol scrollPageToIndexDelegate: NSObjectProtocol {
    func scrollPageToIndexBlock(index:NSInteger)
}
protocol customTitleScrollViewHeightDelegate: NSObjectProtocol {
    func customTitleScrollViewHeight(height:CGFloat)
}
typealias customSCBlock = (_ paramOne : String? ) -> ()
class UNColumnBtns: UIView, UIScrollViewDelegate {
//    private var titleScrollView:UIScrollView = UIScrollView()
//    private var contentView:UIView = UIView()
//    private var lineView:UIView = UIView()
    var customBlock: customSCBlock?
    var presentationStyle = showStyle.defaultStyle
    
    private var contentLabel:UILabel = UILabel()
    private var modelBtn:UIButton = UIButton()
    weak var delegate : scrollPageToIndexDelegate?
    var heightDelegate : customTitleScrollViewHeightDelegate?
    
    
    var btnSizeW:CGFloat = 0;
    var btnSizWAndJianJu:CGFloat = 20;
    var JianJu:CGFloat = 20;

    var semaphoreSignal = DispatchSemaphore(value: 0)
    
//    private var getBtnArr:NSMutableArray = NSMutableArray()
    var titlesArr:NSArray = [] {
            //我们需要在age属性变化前做点什么
            willSet {
                print("willSet12345")
            }
            //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet {
            print("didSet12345")
            self.btnStyle(style: presentationStyle)
            }
        }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.addSubview(self.titleScrollView)
        self.titleScrollView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self);
        }
        self.addSubview(self.contentView)
        self.contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.titleScrollView);
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
     
    @objc func funsetTitlesArr(titlesArr:NSArray){
        
    }

    
    func btnStyle(style:showStyle) -> Void {
        switch style {
        case .defaultStyle:
            self.defaultStyleView();
            break
        case .circularStyle:
            self.circularStyleView();
            break
       
        }
    }
    
    @objc func defaultStyleView(){
       
        self.getBtnArr.removeAllObjects();
        self.contentView.removeFromSuperview()
//                self.contentView = nil;
        self.titleScrollView.addSubview(self.contentView)
        self.contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.titleScrollView);
        }
        let btnArr:NSArray = titlesArr
        self.setNeedsLayout()
        self.layoutIfNeeded()
        var btnSizeW:CGFloat = 0;
        var btnSizWAndJianJu:CGFloat = 20;
        var JianJu:CGFloat = 20;
        let sizeW:CGFloat = self.frame.size.width;
       
        btnArr.enumerateObjects({ (obj, idx, stop) in
            
            let sender:UIButton = UIButton(type: .custom)
            //        let button = UIButton.init()
            //        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
            sender.setTitle(obj as? String, for: UIControl.State.normal)
            sender.backgroundColor = UIColor.green
            sender.tag = idx;
            sender.addTarget(self, action: #selector(titleBtnClick(sender:)), for: UIControl.Event.touchUpInside)
            
            sender.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
            sender.backgroundColor = UIColor.blue;
            self.getBtnArr .add(sender)
            sender.sizeToFit()
            NSLog( "btnSizeW%f",sender.frame.size.width);
            btnSizWAndJianJu += sender.frame.size.width + JianJu;
            btnSizeW += sender.frame.size.width;
        })
        var lastBtn:UIButton? = UIButton();
        self.getBtnArr.enumerateObjects({ (sender, idx, stop) in
        
            let sender:UIButton = sender as! UIButton
            self.contentView .addSubview(sender)

                
                //        如果总按钮宽度+间距 小于当前屏幕的宽
                if (btnSizWAndJianJu<sizeW) {
                    //            总屏幕宽- 按钮的宽 = 剩余宽度
                    let ShengYuW:CGFloat = sizeW - btnSizeW;
                    //这里的间距是平均分的  剩余宽度 /（按钮个数+1）
                    let count:NSInteger = self.getBtnArr.count + 1;
                    JianJu =  ShengYuW / CGFloat(count);
                    
                    if (idx==0) {
                        sender.snp_makeConstraints { (make) in
                            make.left.equalTo(self.contentView).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }else if (idx==btnArr.count-1){
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.right.equalTo(self.contentView.snp_right).offset(-JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }else{
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }
                    lastBtn = sender;
                    
                }else{
                    if (idx==0) {
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(self.contentView).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }else if (idx==btnArr.count-1){
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.right.equalTo(self.contentView.snp_right).offset(-JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }else{
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }
                    lastBtn = sender;
                    
                }
            
        })
        self.setNeedsLayout()
        self.layoutIfNeeded()
        NSLog("contentView%f==%@",self.contentView.frame.size.width,NSCoder.string(for: self.frame));
        let frame: CGRect  = self.contentView.frame;
        if (self.contentView.frame.size.width<self.frame.size.width) {
            self.contentView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: self.frame.size.width, height: frame.size.height);
        }
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.contentView.frame.size.height);
        self.snp_updateConstraints { (make) in
            make.height.equalTo(self.frame.size.height)
        };
//                make.height.equalTo(100);
        let senderBtn:UIButton = self.getBtnArr.firstObject as! UIButton;
        self.lineView.frame = CGRect(x: senderBtn.frame.origin.x, y: self.contentView.frame.size.height-1, width: senderBtn.frame.size.width, height: 1);
        self.contentView.addSubview(self.lineView)
        
        //.m 实现代理
//                if ([self.delegate respondsToSelector:@selector(TPCustomTitleScrollViewHeight:)]) {
//                    [self.delegate TPCustomTitleScrollViewHeight:senderBtn.frame.size.height+20*2];
//                }
        self.heightDelegate?.customTitleScrollViewHeight(height:senderBtn.frame.size.height+20*2)
    }
    @objc func circularStyleView(){
       
        self.getBtnArr.removeAllObjects();
        self.contentView.removeFromSuperview()
//                self.contentView = nil;
        self.titleScrollView.addSubview(self.contentView)
        self.contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.titleScrollView);
        }
        let btnArr:NSArray = titlesArr
        self.setNeedsLayout()
        self.layoutIfNeeded()
        btnSizeW = 0;
        btnSizWAndJianJu = 20;
        JianJu = 0;
        let sizeW:CGFloat = self.frame.size.width;
        let group = DispatchGroup()
        let myQueue = DispatchQueue(label: "queue1")
        
        let semaphoreSignal = DispatchSemaphore(value: 1)
        self.semaphoreSignal = semaphoreSignal;
        
        myQueue.async(group: group, qos: .default, flags: [], execute: {
            self.semaphoreSignal.wait()
            print("耗时任务一")
            DispatchQueue.main.async {
            self.cereatBtn(btnArr: btnArr,  sizeW: sizeW);

            }


        })
        myQueue.async(group: group, qos: .default, flags: [], execute: {
            self.semaphoreSignal.wait()
            print("耗时任务二")
            DispatchQueue.main.async {
                self.cereatBtnTo( btnArr: btnArr,sizeW: sizeW);

            }
        })
        //执行完上面的两个耗时操作, 回到myQueue队列中执行下一步的任务
        group.notify(queue: myQueue) {
            DispatchQueue.main.async {
                print("回到该队列中执行")
                self.updateUI()
            }
        }
        
        
        
        
        
        
        
//            DispatchQueue.global().async {
//                self.semaphoreSignal.wait()
//                print("步骤一：" ,Thread.current)
//                DispatchQueue.main.async {
//                    self.cereatBtn(btnArr: btnArr,  sizeW: sizeW);
//                }
////                   semaphoreSignal.signal()
//            }
//            DispatchQueue.global().async {
//                self.semaphoreSignal.wait()
//               print("步骤二：" ,Thread.current)
//                DispatchQueue.main.async {
//                    self.cereatBtnTo( btnArr: btnArr,sizeW: sizeW);
//                }
//            }
//        DispatchQueue.global().async {
//            self.semaphoreSignal.wait()
//            print("步骤三：" ,Thread.current)
//            DispatchQueue.main.async {
//                self.updateUI()
//
//            }
//        }
              
        
       
        
        
    }
    @objc func cereatBtn(btnArr:NSArray,sizeW:CGFloat){
        btnArr.enumerateObjects({ (obj, idx, stop) in
            let dicObj:NSDictionary = obj as! NSDictionary;
            let title:NSString = dicObj.allKeys.first as! NSString
            var currentImage:NSString = dicObj.allValues.first as! NSString
            let sender:UIButton = UIButton(type: .custom)
            sender.setTitle(title as String , for: UIControl.State.normal)
            sender.setTitleColor(UIColor.green, for: UIControl.State.normal)
//            sender.setImage(UIImage.init(named: image as String), for: UIControl.State.normal)
            
//            let url = URL.init(fileURLWithPath: currentImage as String)
//            var URL = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2797486824,1669366989&fm=26&gp=0.jpg"
//            URL = "http://mp.open-roc.com/ormp/userfiles/fileupload/201911/1199957084442476546.png"
//            URL =  "http://mp.open-roc.com/ormp/userfiles/fileupload/201911/1199925494072311810.png"
//            self.downloadedFrom(imageurl: currentImage as String, btn: sender);
            if(currentImage.length == 0){
                currentImage = "nil"
            }
            let iconA = UIImage(named: currentImage as String);
            var phStr = "icon_head"
            if((iconA) != nil){
                phStr = currentImage as String
            }
            let url = URL(string: currentImage as String)!
            let imageIcon:UIImageView = UIImageView()
            imageIcon.kf.setImage(with: ImageResource(downloadURL: url ), placeholder: UIImage(named: phStr as String), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                if((image == nil)){
                    self.setImgIcon(imageIcon: imageIcon, sender: sender, idx: idx, btnArr: btnArr);
                }else{
                    self.setImgIcon(imageIcon: imageIcon, sender: sender, idx: idx, btnArr: btnArr);
                }
                

            })
            
            /*
            sender.kf.setImage(with: ImageResource(downloadURL: url ),for: UIControl.State.normal,  placeholder: UIImage(named: currentImage as String), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                let reSize = CGSize(width: 80, height: 80)
                sender.imageView!.image = image?.reSizeImage(reSize: reSize)
//                sender.setImage(imageIcon.image, for: UIControl.State.normal)
                sender.tag = idx;
                sender.addTarget(self, action: #selector(self.titleBtnClick(sender:)), for: UIControl.Event.touchUpInside)
                sender.backgroundColor = UIColor.blue
//                sender.frame = CGRect(x: sender.frame.origin.x,y:sender.frame.origin.y,width: 80,height: 80);
    //            sender.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    //            sender.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    //            let conEdgeTop:CGFloat = 5;
    //            let contEdgeBottom:CGFloat = 50;
    //            sender.contentEdgeInsets = UIEdgeInsets(top: conEdgeTop, left: 0, bottom: contEdgeBottom, right: 0);
    //            sender.frame = CGRect(x: sender.frame.origin.x,y: sender.frame.origin.y,width: sender.frame.size.width,height: sender.frame.size.height + (conEdgeTop + contEdgeBottom))
                self.getBtnArr .add(sender)
                sender.sizeToFit()
                self.adjustButtonImageViewUPTitleDownWithButton(button: sender);
//
                NSLog( "btnSizeW%f",sender.frame.size.width);
                self.btnSizWAndJianJu += sender.frame.size.width + self.JianJu;
                self.btnSizeW += sender.frame.size.width;
                if (idx==btnArr.count-1){
                    self.semaphoreSignal.signal()
                }

            })
            */

           
        })
    }
    @objc func setImgIcon(imageIcon:UIImageView,sender:UIButton,idx:NSInteger,btnArr:NSArray){
        let reSize = CGSize(width: 60, height: 60)
        imageIcon.image = imageIcon.image!.reSizeImage(reSize: reSize)
        
        sender.setImage(imageIcon.image, for: UIControl.State.normal)
        sender.imageView!.layer.cornerRadius = reSize.width/2
        sender.imageView!.layer.masksToBounds = true
        
        sender.tag = idx;
        sender.addTarget(self, action: #selector(self.titleBtnClick(sender:)), for: UIControl.Event.touchUpInside)
//                sender.backgroundColor = UIColor.blue
        self.getBtnArr .add(sender)
        sender.sizeToFit()
        self.adjustButtonImageViewUPTitleDownWithButton(button: sender);
        let conEdgeTop:CGFloat = 0;
        let contEdgeBottom:CGFloat = 10;
        sender.contentEdgeInsets = UIEdgeInsets(top: conEdgeTop, left: 0, bottom: contEdgeBottom, right: 0);
        NSLog( "btnSizeW%f",sender.frame.size.width);
        self.btnSizWAndJianJu += sender.frame.size.width + self.JianJu;
        self.btnSizeW += sender.frame.size.width;
        if (idx==btnArr.count-1){
            self.semaphoreSignal.signal()
        }
    }
    @objc func cereatBtnTo(btnArr:NSArray,sizeW:CGFloat){
        var lastBtn:UIButton? = UIButton();
        self.getBtnArr.enumerateObjects({ (sender, idx, stop) in
        
            let sender:UIButton = sender as! UIButton
            self.contentView .addSubview(sender)

                
                //        如果总按钮宽度+间距 小于当前屏幕的宽
                if (btnSizWAndJianJu<sizeW) {
                    //            总屏幕宽- 按钮的宽 = 剩余宽度
                    let ShengYuW:CGFloat = sizeW - btnSizeW;
                    //这里的间距是平均分的  剩余宽度 /（按钮个数+1）
                    let count:NSInteger = self.getBtnArr.count + 1;
                    self.JianJu =  ShengYuW / CGFloat(count);
                    
                    if (idx==0) {
                        sender.snp_makeConstraints { (make) in
                            make.left.equalTo(self.contentView).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                            
                        };
                    }else if (idx==btnArr.count-1){
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.right.equalTo(self.contentView.snp_right).offset(-JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }else{
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
                        };
                    }
                    lastBtn = sender;
                    
                }else{
                    
                    //            总屏幕宽- 按钮的宽 = 剩余宽度
//                    let ShengYuW:CGFloat = sizeW - self.btnSizeW;
//                    //这里的间距是平均分的  剩余宽度 /（按钮个数+1）
//                    let count:NSInteger = self.getBtnArr.count + 1;
//                    self.JianJu =  ShengYuW / CGFloat(count);
                    if (idx==0) {
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(self.contentView).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
//                            make.width.equalTo(80);
//                            make.height.equalTo(60);
                        };
                    }else if (idx==btnArr.count-1){
                        
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.right.equalTo(self.contentView.snp_right).offset(-JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
//                            make.width.equalTo(80);
//                            make.height.equalTo(60);
                        };
                    }else{
                        sender .snp_makeConstraints { (make) in
                            make.left.equalTo(lastBtn!.snp_right).offset(JianJu);
                            make.top.equalTo(self.contentView).offset(20);
                            make.bottom.equalTo(self.contentView).offset(-20);
//                            make.width.equalTo(80);
//                            make.height.equalTo(60);
                        };
                    }
                    lastBtn = sender;
                    
                }
            
        })
        self.semaphoreSignal.signal()
    }
    @objc func updateUI(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
        NSLog("contentView%f==%@",self.contentView.frame.size.width,NSCoder.string(for: self.frame));
        let frame: CGRect  = self.contentView.frame;
        if (self.contentView.frame.size.width<self.frame.size.width) {
            self.contentView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: self.frame.size.width, height: frame.size.height);
        }
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.contentView.frame.size.height);
        self.snp_updateConstraints { (make) in
            make.height.equalTo(self.frame.size.height + 10)
        };

//                make.height.equalTo(100);
        let senderBtn:UIButton = self.getBtnArr.firstObject as! UIButton;
        self.lineView.frame = CGRect(x: senderBtn.frame.origin.x, y: self.contentView.frame.size.height-1, width: senderBtn.frame.size.width, height: 1);
        self.contentView.addSubview(self.lineView)

        //.m 实现代理
//                if ([self.delegate respondsToSelector:@selector(TPCustomTitleScrollViewHeight:)]) {
//                    [self.delegate TPCustomTitleScrollViewHeight:senderBtn.frame.size.height+20*2];
//                }
        self.heightDelegate?.customTitleScrollViewHeight(height:self.frame.size.height + 10)
//        self.semaphoreSignal.signal()
    }
    
    
    func downloadedFrom(imageurl : String,btn:UIButton){
            //创建URL对象
            let url = URL(string: imageurl)!
            //创建请求对象
            let request = URLRequest(url: url)

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if error != nil{
                    print(error.debugDescription)
                }else{
                    //将图片数据赋予UIImage
                    let img = UIImage(data:data!)

                    // 这里需要改UI，需要回到主线程
                    DispatchQueue.main.async {
                        btn.setImage(img, for: UIControl.State.normal)
                    }

                }
            }) as URLSessionTask

            //使用resume方法启动任务
            dataTask.resume()
        }
    
    
    func adjustButtonImageViewUPTitleDownWithButton(button:UIButton) {
        button.superview? .layoutIfNeeded();
        //使图片和文字居左上角
        button.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.top
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        let buttonHeight:CGFloat  = button.frame.height;
        let buttonWidth:CGFloat  = button.frame.width;
        let ivHeight:CGFloat  = (button.imageView?.frame.size.height)!
        let ivWidth:CGFloat  = (button.imageView?.frame.size.width)!
        
        let titleHeight:CGFloat  = (button.titleLabel?.frame.size.height)!
        let titleWidth:CGFloat  = (button.titleLabel?.frame.size.width)!
        //调整图片
        let iVOffsetY:CGFloat  = buttonHeight / 2.0 - (ivHeight + titleHeight) / 2.0;
        let iVOffsetX:CGFloat  = buttonWidth / 2.0 - ivWidth / 2.0;
        button.imageEdgeInsets = UIEdgeInsets(top: iVOffsetY, left: iVOffsetX, bottom: 0, right: 0)
    
        
        //调整文字
        let titleOffsetY:CGFloat  = iVOffsetY + (button.imageView?.frame.size.height)! + 10;
        var titleOffsetX:CGFloat  = 0;
        let rectImgW:CGFloat = (button.imageView?.frame.size.width)!
        let rectBtnW:CGFloat = (button.frame.size.width)
        if ((rectImgW) >= (rectBtnW / 2.0)) {
            //如果图片的宽度超过或等于button宽度的一半
            titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
        }else {
            titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
        }
        button.titleEdgeInsets = UIEdgeInsets(top: titleOffsetY , left: titleOffsetX, bottom: 0, right: 0);
    }

    
//    接口
    @objc func titleStatusChangeWithProgress(progress:CGFloat,fromIndex:NSInteger,toIndex:NSInteger){
        
        if (toIndex > self.getBtnArr.count - 1) {
            return;
        }
        if (fromIndex < 0) {
            return;
        }
        // 1.取出源和目标按钮
        let sourceTitleBtn:UIButton = self.getBtnArr[fromIndex] as! UIButton;
        let targetTitleBtn:UIButton = self.getBtnArr[toIndex] as! UIButton;
        
        var lineFrame:CGRect  = self.lineView.frame;
        //    // 2.根据进度改变滑块的位置和宽度
        let moveTotalX:CGFloat  = targetTitleBtn.frame.origin.x - sourceTitleBtn.frame.origin.x;
        let moveX:CGFloat  = moveTotalX * progress;
        lineFrame.origin.x = sourceTitleBtn.frame.origin.x + moveX;
        lineFrame.size.width = sourceTitleBtn.frame.size.width + (targetTitleBtn.frame.size.width - sourceTitleBtn.frame.size.width) * progress;
        self.lineView.frame = CGRect(x: lineFrame.origin.x, y: lineFrame.origin.y, width: lineFrame.size.width, height: self.lineView.frame.size.height);
        
        // 3. 处理外界界面左滑右滑标题按钮的选中以及指示器的状态
        if (1.0 != progress) {
            return;
        }
        
        if (fromIndex < toIndex) {
            
            // 让标题判断并滚动到中间
            self.scrollTitleWithIndex(index: toIndex)
        } else {
            
            // 右滑
            // 让标题判断并滚动到中间
            self.scrollTitleWithIndex(index: toIndex)
            
        }
    }
    @objc func titleBtnClick(sender:UIButton){
        UIView.animate(withDuration: 0.485) {
            self.lineView.frame = CGRect(x: sender.frame.origin.x, y: self.contentView.frame.size.height-1, width: sender.frame.size.width, height: 1);
        }
        self.scrollTitleWithIndex(index: sender.tag)
        self.delegate?.scrollPageToIndexBlock(index: sender.tag)
        if(customBlock != nil) {
            customBlock!("customBlock的值")
        }
        
//        if self.delegate != nil && (self.delegate?.responds(to: Selector.init(("scrollPageToIndexBlock:"))))!{
//
//        }
        
    }
    func customBlockFunction ( block: @escaping (_ paramOne : String? ) -> () ) {
        customBlock = block
    }


    @objc func scrollTitleWithIndex(index:NSInteger){
        // 获取当前选中的标题按钮
        let btn:UIButton  = self.getBtnArr[index] as! UIButton;
        // 获取当前标题按钮的中心 x 轴
        let btnCenterX:CGFloat  = btn.center.x;
        var offset:CGPoint  = self.titleScrollView.contentOffset;
        // 求将该选中的标题按钮滚动到中间的偏移量
        offset.x = btnCenterX - self.titleScrollView.frame.size.width * 0.5;
        // 左边超出处理
        if (offset.x < 0) {
            offset.x = 0;
        }
        // 右边超出处理
        let maxTitleOffsetX:CGFloat  = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
        if (offset.x > maxTitleOffsetX ) {
            offset.x = maxTitleOffsetX;
        }
        self.titleScrollView.setContentOffset(offset, animated: true)
        
    }
    lazy  var titleScrollView:UIScrollView = {
            var  titleScroll  =  UIScrollView.init()
                 titleScroll.delegate = self
                 titleScroll.showsHorizontalScrollIndicator = false
                 titleScroll.backgroundColor = UIColor.orange;

            return titleScroll

        }()
    
    lazy  var lineView:UIView = {
            var  view  =  UIView.init()
            view.backgroundColor = UIColor .purple;

            return view

        }()
    lazy  var contentView:UIView = {
            var  view  =  UIView.init()
            view.backgroundColor = UIColor .white;

            return view

        }()
    lazy  var getBtnArr:NSMutableArray = {
            var  array  =  NSMutableArray()
            return array

        }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
     
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
