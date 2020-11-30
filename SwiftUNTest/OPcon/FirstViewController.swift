//
//  FirstViewController.swift
//  TestSwift
//
//  Created by  open-roc on 2018/5/3.
//  Copyright © 2018年  open-roc. All rights reserved.
//

import UIKit
import AVFoundation
class FirstViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    typealias lewisCloser = (_ paramOne : String? ) -> ()
    var loadImage = UIImageView()
    var action: (() -> (Swift.Void))?
    var customeCloser: lewisCloser?
//    var action: ((_ str: inout NSString) -> ())?
//    var action: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backBarButtonItem?.title="返回"
        self.title = "first";
        
        
        self.loadImage = UIImageView(image:UIImage(named:"WX20180420-161313"))
        //        loadImage.image = UIImage(named: "WX20180420-161313")
        self.loadImage.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        self.loadImage.backgroundColor = UIColor.brown
        self.view .addSubview(self.loadImage)
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let button:UIButton = UIButton(type: .custom)
        //        let button = UIButton.init()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        button.setTitle("小王", for: UIControl.State.normal)
        button.backgroundColor = UIColor.green
        
        button.addTarget(self, action: #selector(FirstViewController.msg), for: UIControl.Event.touchUpInside)
        
        self.view .addSubview(button)
        if(customeCloser != nil) {
            customeCloser!("要发给第一个界面的值")
        }
        
        let test={(_ name:String)->() in
            
            // in 后面就是回调之后处理的函数 ，相当于是Block之后的{ }
            print(name)
            
        }
        test("测试")
//        self.msgBlock
    }
    @objc open func msg(){
        print("传值啦")
//        self.addIcon()
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.view.backgroundColor = UIColor .red
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            //                MBProgressHUD.showForError(to: self.view, text: "为授予防问相机权限", completion: nil)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //调用相机
    func addIcon()  {
        
        let alertAction = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertAction.addAction(UIAlertAction.init(title: "获取相机", style: .default, handler: { (alertCamera) in
            
            let picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = .camera
            picker.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                self.present(picker, animated: true, completion: { () -> Void in
                    
                })
            }else{
//                MBProgressHUD.showForError(to: self.view, text: "为授予防问相机权限", completion: nil)
            }
        }))
        
        alertAction.addAction(UIAlertAction.init(title: "获取相册", style:.default, handler: { (alertPhpto) in
            
            let picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                self.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else{
//                MBProgressHUD.showForError(to: self.view, text: "为授予防问相册权限", completion: nil)
            }
        }))
        
        alertAction.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertCancel) in
            
        }))
        
        self.present(alertAction, animated: true, completion: nil)
    }
    
    // MARK: ImagePicker Delegate 选择图片成功后代理
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let chosenImage =  info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            picker.dismiss(animated: true) {
                self.loadImage.image = chosenImage
                // 将image对象保存到相册中
                // 将image对象保存到相册中
                // 图片保存到相册
                UIImageWriteToSavedPhotosAlbum(chosenImage, self, #selector(FirstViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
    
                // Selector的旧写法
                // UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
            }
            //处理传入后台
        }
    }
    @objc private func image(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo : AnyObject) {
//        var showInfo = ""
        if error != nil {
//            showInfo = "保存失败"
        } else {
//            showInfo = "保存成功"
        }
        
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
