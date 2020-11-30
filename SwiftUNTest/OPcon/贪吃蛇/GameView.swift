//
//  GameView.swift
//  TestSwift
//
//  Created by open-roc on 2019/11/15.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit

class GameView: UIView {
    var snake = Snake();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func draw(_ rect: CGRect) {
        if self.snake.nodes.count == 0 {
            return;
        }
        let node:Node = self.snake.nodes.firstObject as! Node;
        
        var center = node.coordinate;
        var bezierPath = UIBezierPath();
        self.drawHead(bezierPath: bezierPath, center: center);
        UIColor.purple.set();
        bezierPath.lineWidth = 1;
        bezierPath.fill();
        
//        var  i = Int();

        for i in self.snake.nodes {
            let node:Node = i as! Node 
            center = node.coordinate;
            let rectangle = CGRect.init(x: center.x - CGFloat(Double(NODEWH) * 0.5), y:center.y - CGFloat( Double(NODEWH) * 0.5), width: CGFloat(NODEWH), height: CGFloat(NODEWH));
            bezierPath = UIBezierPath.init(ovalIn: rectangle);
            bezierPath.fill();
        }
    
    }
    func drawHead(bezierPath:UIBezierPath,center:CGPoint) -> () {
        let halfW:CGFloat = CGFloat(Double(NODEWH) * 0.5);
        
        switch (self.snake.direction) {
        case .MoveDirectionRight:
            bezierPath.move(to: CGPoint.init(x: center.x - halfW, y: center.y - halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x - halfW, y: center.y + halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x + halfW, y: center.y));
                   
                   break;
        case .MoveDirectionLeft:
            bezierPath.move(to: CGPoint.init(x: center.x - halfW, y: center.y));
            bezierPath.addLine(to: CGPoint.init(x: center.x + halfW, y: center.y + halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x + halfW, y: center.y - halfW));
              
                  
                   break;
        case .MoveDirectionDown:
            bezierPath.move(to: CGPoint.init(x: center.x - halfW, y: center.y - halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x + halfW, y: center.y - halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x, y: center.y + halfW));

                   break;
        case .MoveDirectionUp:
            bezierPath.move(to: CGPoint.init(x: center.x, y: center.y - halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x - halfW, y: center.y + halfW));
            bezierPath.addLine(to: CGPoint.init(x: center.x + halfW, y: center.y + halfW));
                   
                   break;
               default:
                   break;
           }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super .awakeFromNib()
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.init(white: 0, alpha: 0.1).cgColor;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
