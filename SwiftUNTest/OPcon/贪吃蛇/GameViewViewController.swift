//
//  GameViewViewController.swift
//  TestSwift
//
//  Created by open-roc on 2019/11/15.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
var LEVELCOUNT = 10 //多少分为1级
var MAXLEVEL = 9    //最高多少级

class GameViewViewController: UIViewController ,UIAlertViewDelegate{
    var snake = Snake();
    var food = UIImageView();
    var isGameOver = Bool();
    var backGroundImage = UIImageView();
    var footImage = UIImageView();
    var gameView1 = GameView();
    var scoreLabel1 = UILabel();
    var levelLabel1 = UILabel();
    var jcBtn = UIButton();
    var startBtn1 = UIButton();
    var UP = UIButton();
    var Down = UIButton();
    var Left = UIButton();
    var Right = UIButton();
    var score = NSInteger();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        self.backGroundImage = UIImageView.init()
        self.backGroundImage.image = UIImage.init(named: "background")
        
        self.footImage = UIImageView.init()
        self.footImage.image = UIImage.init(named: "bottomImage")
        
        
        self.food = UIImageView.init()
        self.food.frame = CGRect(x: 0, y: 0, width: NODEWH, height: NODEWH)
        self.food.image = UIImage.init(named: "icon_星星2")
        self.gameView1 .addSubview(self.food)
        
        self.gameView1 = GameView.init()
        self.gameView1.layer.borderColor = UIColor.lightGray.cgColor;
        self.gameView1.layer.borderWidth = 1.0;
        
        self.scoreLabel1 = UILabel.init()
        self.scoreLabel1.textColor = UIColor.white;
        self.scoreLabel1.font = UIFont.systemFont(ofSize: 14);
        self.scoreLabel1.textAlignment = NSTextAlignment.left;
        self.scoreLabel1.numberOfLines = 0;
        self.scoreLabel1.text = NSString(format: "分数：%d",0) as String
        
        
        self.levelLabel1 = UILabel.init()
        self.levelLabel1.textColor = UIColor.white;
        self.levelLabel1.font = UIFont.systemFont(ofSize: 14);
        self.levelLabel1.textAlignment = NSTextAlignment.left;
        self.levelLabel1.numberOfLines = 0;
        self.levelLabel1.text = NSString(format: "等级：%d",0) as String
     
        
        self.UP = UIButton.init(type: .custom)
        self.UP.frame = CGRect.zero;
        self.UP.tag = 0;
        self.UP.layer.masksToBounds = true;
        self.UP.layer.cornerRadius = 4;
        self.UP.backgroundColor = UIColor.blue;
        self.UP.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.UP.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.UP.setTitle("UP", for: UIControl.State.normal)
        self.UP.addTarget(self, action: #selector(btnClick(sender:)), for: UIControl.Event.touchUpInside)
        
        
        self.Left = UIButton.init(type: .custom)
        self.Left.frame = CGRect.zero;
        self.Left.tag = 0;
        self.Left.layer.masksToBounds = true;
        self.Left.layer.cornerRadius = 4;
        self.Left.backgroundColor = UIColor.blue;
        self.Left.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.Left.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.Left.setTitle("Left", for: UIControl.State.normal)
        self.Left.addTarget(self, action: #selector(btnClick(sender:)), for: UIControl.Event.touchUpInside)
        
        
        self.Down = UIButton.init(type: .custom)
        self.Down.frame = CGRect.zero;
        self.Down.tag = 0;
        self.Down.layer.masksToBounds = true;
        self.Down.layer.cornerRadius = 4;
        self.Down.backgroundColor = UIColor.blue;
        self.Down.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.Down.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.Down.setTitle("Down", for: UIControl.State.normal)
        self.Down.addTarget(self, action: #selector(btnClick(sender:)), for: UIControl.Event.touchUpInside)
        
        self.Right = UIButton.init(type: .custom)
        self.Right.frame = CGRect.zero;
        self.Right.tag = 0;
        self.Right.layer.masksToBounds = true;
        self.Right.layer.cornerRadius = 4;
        self.Right.backgroundColor = UIColor.blue;
        self.Right.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.Right.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.Right.setTitle("Right", for: UIControl.State.normal)
        self.Right.addTarget(self, action: #selector(btnClick(sender:)), for: UIControl.Event.touchUpInside)
        
        
        
        self.startBtn1 = UIButton.init(type: .custom)
        self.startBtn1.frame = CGRect.zero;
        self.startBtn1.tag = 0;
        self.startBtn1.layer.masksToBounds = true;
        self.startBtn1.layer.cornerRadius = 4;
        self.startBtn1.backgroundColor = UIColor.blue;
        self.startBtn1.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.startBtn1.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.startBtn1.setTitle("开始", for: UIControl.State.normal)
        self.startBtn1.addTarget(self, action: #selector(pause(sender:)), for: UIControl.Event.touchUpInside)
        
        let width:CGFloat = self.view.frame.size.width;
        self.jcBtn = UIButton.init(type: .custom)
        self.jcBtn.frame = CGRect(x: width-120, y: 50, width: 100, height: 40);
        self.jcBtn.layer.masksToBounds = true;
        self.jcBtn.layer.cornerRadius = 4;
        self.jcBtn.backgroundColor = UIColor.white;
        self.jcBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20);
        self.jcBtn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        self.jcBtn.setTitle("退出游戏", for: UIControl.State.normal)
        self.jcBtn.addTarget(self, action: #selector(jcBtnClicked), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(self.backGroundImage);
        self.backGroundImage.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view).offset(0)
            
        }
        self.view.addSubview(self.footImage);
        self.footImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.backGroundImage.snp_bottom).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
            
        }
        
        self.view.addSubview(self.gameView1);
        self.gameView1.snp.makeConstraints { (make) in
            make.center.equalTo(self.backGroundImage).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        
        self.footImage.addSubview(self.scoreLabel1);
        self.scoreLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(30)
        }
        
        self.footImage.addSubview(self.levelLabel1);
        self.levelLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(self.scoreLabel1.snp_bottom).offset(10)
        }
        self.footImage.addSubview(self.startBtn1);
        self.startBtn1.snp.makeConstraints { (make) in
            make.center.equalTo(self.footImage);
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        
        self.footImage.addSubview(self.UP);
        self.UP.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.startBtn1.snp_top).offset(-15);
            make.centerX.equalTo(self.footImage);
            make.width.equalTo(60);
            make.height.equalTo(60);
        }
        
        self.footImage.addSubview(self.Left);
        self.Left.snp.makeConstraints { (make) in
            make.right.equalTo(self.startBtn1.snp_left).offset(-15);
            make.centerY.equalTo(self.footImage);
            make.width.equalTo(60);
            make.height.equalTo(60);
        }
        
        self.footImage.addSubview(self.Down);
        self.Down.snp.makeConstraints { (make) in
            make.top.equalTo(self.startBtn1.snp_bottom).offset(15);
            make.centerX.equalTo(self.footImage);
            make.width.equalTo(60);
            make.height.equalTo(60);
        }
        
        self.footImage.addSubview(self.Right);
        self.Right.snp.makeConstraints { (make) in
            make.left.equalTo(self.startBtn1.snp_right).offset(15);
            make.centerY.equalTo(self.footImage);
            make.width.equalTo(60);
            make.height.equalTo(60);
        }
        
        
        self.snake = Snake.snake();
        self.snake.moveFinishBlock = { index in
            self.isEatedFood()
            self.isDestroy()
            self.gameView1.setNeedsDisplay()
        }
        self.gameView1.snake = self.snake
        self.createFood()
        self.view.addSubview(self.jcBtn)
    }
    
    func createFood() -> () {
        let x:Int = Int(arc4random() % 20) * NODEWH + Int(Double(NODEWH) * 0.5)
        let y:Int = Int(arc4random() % 30) * NODEWH + Int(Double(NODEWH) * 0.5)
        let center:CGPoint = CGPoint(x:x, y:y);
        for node  in self.snake.nodes {
            let node:Node = node as! Node
            if __CGPointEqualToPoint(center, node.coordinate) {
                self.createFood()
                return;
            }
        }
        self.food.center = center;
    }
    
    func isEatedFood() -> () {
        let node:Node = self.snake.nodes.firstObject as! Node
        if __CGPointEqualToPoint(self.food.center, node.coordinate) {
            let score:NSInteger = self.score + 1
            self.score = score;
            self.scoreLabel1.text = NSString(format: "分数：%d",score) as String
            if score <= LEVELCOUNT * MAXLEVEL && (score % LEVELCOUNT == 0) {
                let level:NSInteger = score / LEVELCOUNT;
                self.snake.levelUpWithSpeed(speed: level);
                self.levelLabel1.text = NSString(format: "等级：%d",level) as String
                
            }
            self.createFood()
            self.snake.growUp()
        }
    }
    func isDestroy() -> () {
        
        let head:Node = self.snake.nodes.firstObject as! Node
        for i in self.snake.nodes {
            let  node:Node = self.snake.nodes[i as! Int] as! Node
            if __CGPointEqualToPoint(head.coordinate, node.coordinate) {
                self.gameOver()
            }
            
        }
        
        
        if head.coordinate.x < 5 || head.coordinate.x > 195 {
            self.gameOver()
        }
        
        if head.coordinate.y < 5 || head.coordinate.y > 295 {
            self.gameOver()
        }
    }
    
    func gameOver() -> () {
        
        self.snake.pause()
//        let message:NSString = NSString.init(cString:"总得分：%@，不服再来？",self.scoreLabel1)
        let message:NSString = NSString(format: "总得分：%@，不服再来？",(self.scoreLabel1.text! as  NSString))
        let alertAction = UIAlertController.init(title: "Game Over", message: message as String, preferredStyle: UIAlertController.Style.alert)
        
        alertAction.addAction(UIAlertAction.init(title: "不服", style:.default, handler: { (alertPhpto) in
                    
                self.score = 0;
                self.scoreLabel1.text = NSString(format: "分数：%d",0) as String
                self.levelLabel1.text = NSString(format: "等级：%d",0) as String
                self.createFood()
                self.snake.reset()

            }))
                
                alertAction.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alertCancel) in
                    self.startBtn1.isSelected = false;
                    self.isGameOver = true;
                }))
                
            self.present(alertAction, animated: true, completion: nil)
    }
    
    
    
    @objc func btnClick(sender:UIButton) -> () {
        if self.startBtn1.isSelected {
            self.snake.direction = MoveDirection(rawValue: sender.tag)
        }
    }
    
    
    @objc func pause(sender:UIButton) -> () {
        if sender.isSelected {
            self.snake.pause()
        }else{
            if self.isGameOver{
                self.score = 0
                self.scoreLabel1.text = NSString(format: "分数：%d",0) as String
                self.levelLabel1.text = NSString(format: "等级：%d",0) as String
                self.snake.reset()
                self.isGameOver = false
            }else{
                self.snake.start()
            }
        }
        sender.isSelected = !sender.isSelected
    }
    
    @objc func jcBtnClicked() -> () {
           
        exit(0);
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
