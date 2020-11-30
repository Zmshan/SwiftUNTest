//
//  UNBannerView.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/12.
//

import UIKit
import Kingfisher
class UNBannerView: UIView ,UIScrollViewDelegate{
    
    enum ImageType{
        case Image     //本地图片
        case URL       //URL
    }
     
    //图片水平放置到scrollView上
    private var scrollView:UIScrollView = UIScrollView()
    //小圆点标识
    private var pageControl:UIPageControl = UIPageControl()
 
    private var center_image:UIImageView = UIImageView()
    private var first_image:UIImageView = UIImageView()
    private var second_image:UIImageView = UIImageView()
    //图片集合
    private var images:Array<String> = []
    private var type:ImageType = .Image
     
    private var width:CGFloat = 0
    private var height:CGFloat = 0
     
    private var currIndex = 0
    private var clickBlock :(Int)->Void = {index in}
     
    private var timer:Timer?
     
    // 默认自动播放 设置为false只能手动滑动
    var isAuto = true
    // 轮播间隔时间 默认4秒可以自己修改
    var interval:Double = 4
     
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.initLayout()
    }
     
    public func setImages(images:Array<String>,type:ImageType = .Image,imageClickBlock:@escaping (Int) -> Void) {
        self.type = type
        self.images = images
        self.clickBlock = imageClickBlock
        self.initLayout()
    }
     
    private func initLayout(){
        if(self.images.count == 0){
            return
        }
         
        width = frame.size.width
        height = frame.size.height
         
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width:width * CGFloat(3),height:height)
        scrollView.contentOffset = CGPoint(x:width,y:0)
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)
         
        first_image.frame = CGRect(x:0,y:0,width:width,height:height)
        first_image.contentMode = .scaleAspectFill
        first_image.isUserInteractionEnabled = true
        scrollView.addSubview(first_image)
         
        center_image.frame = CGRect(x:width,y:0,width:width,height:height)
        center_image.contentMode = .scaleAspectFill
        center_image.isUserInteractionEnabled = true
        scrollView.addSubview(center_image)
         
        second_image.frame = CGRect(x:width * 2.0,y:0,width:width,height:height)
        second_image.contentMode = .scaleAspectFill
        second_image.isUserInteractionEnabled = true
        scrollView.addSubview(second_image)
         
         
        pageControl.center = CGPoint(x:width/2,y:height - CGFloat(15))
        pageControl.isEnabled = true
        pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
         
        //当前显示的只有 center_image 其他两个只是用来增加滑动时效果而已，不需要添加点击事件
        addTapGesWithImage(image: center_image)
        if(isAuto){
            openTimer()
        }
        setCurrent(currIndex: 0)
    }
     
    func setCurrent(currIndex:Int) {
        self.currIndex = currIndex
         
        if(type == .Image){
            center_image.image = UIImage.init(named:images[currIndex])
            first_image.image = UIImage.init(named:images[(currIndex - 1 + images.count) % images.count])
            second_image.image = UIImage.init(named:images[(currIndex + 1) % images.count])
        }else{
            
           
                
            center_image.setMyImage(URL: NSURL(string: images[currIndex]))
            first_image.setMyImage(URL: NSURL(string: images[(currIndex - 1 + images.count) % images.count]))
            second_image.setMyImage(URL: NSURL(string: images[(currIndex + 1) % images.count]))
        }
        center_image.tag = currIndex
        pageControl.currentPage = currIndex
        scrollView.setContentOffset(CGPoint(x:width,y:0), animated: false)
    }
     
    //给图片添加点击手势
    private func addTapGesWithImage(image:UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        image.isUserInteractionEnabled = true //让控件可以触发交互事件
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true //超出父控件的部分不显示
        image.addGestureRecognizer(tap)
    }
     
    //点击图片，调用block
    @objc func tap(_ ges:UITapGestureRecognizer) {
        clickBlock((ges.view?.tag)!)
    }
     
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
    }
     
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        closeTimer()
    }
     
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        openTimer()
    }
     
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.x > 0){
            currIndex = (currIndex + 1) % images.count
        }else{
            currIndex = (currIndex - 1 + images.count) % images.count
        }
        setCurrent(currIndex: currIndex)
    }
     
    func openTimer(){
        if(isAuto){
            if(timer == nil){
                 timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startAutoScroll), userInfo: nil, repeats: true)
            }
             
        }
    }
     
    func closeTimer(){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
    }
     
     
    @objc func startAutoScroll(){
        if(isDisplayInScreen()){
            setCurrent(currIndex: (currIndex + 1) % images.count)
        }
    }
     
    func isDisplayInScreen() -> Bool{
        if(self.window == nil){
            return false
        }
        return true
    }
     
}
 
extension UIImageView{
    // Kingfisher的覆盖  好处：1.不用所有界面都去导入 2.如果KingfisherAPI更新或者更换图片加载库可以更方便一些，保持方法名和第一个参数不变，修改一下就能达到目的，比如修改为使用SDWebImage
    public func setMyImage(URL: NSURL?,placeholderImage: Image? = nil,
                                  optionsInfo: KingfisherOptionsInfo? = nil,
                                  progressBlock: DownloadProgressBlock? = nil,
                                  completionHandler: CompletionHandler? = nil){
      
        kf.setImage(with: ImageResource(downloadURL: URL! as URL ),
                           placeholder: placeholderImage,
                           options: optionsInfo,
                                  progressBlock: progressBlock,
                                  completionHandler: completionHandler)
    }
}
