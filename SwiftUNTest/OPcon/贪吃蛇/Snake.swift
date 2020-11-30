//
//  Snake.swift
//  TestSwift
//
//  Created by open-roc on 2019/11/15.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
typealias MoveFinish = (NSInteger) -> Void
enum MoveDirection:Int {
    case MoveDirectionUp
    case MoveDirectionLeft
    case MoveDirectionDown
    case MoveDirectionRight
}
class Snake: NSObject {
    var timer = Timer();
    var speed = NSInteger();
    var lastPoint = CGPoint();
//    var nodes:Array<Node > = NSMutableArray() as! Array<Node>;
    var nodes = NSMutableArray() ;
//    var nodes:Array<Node> = [];
    var direction:MoveDirection?{
        willSet{
        
            print("willSet\(String(describing: direction))--")
        }
        didSet{
            
            print("didSet\(String(describing: direction))--")
            if direction == MoveDirection.MoveDirectionDown || direction == MoveDirection.MoveDirectionUp {
                
                if direction == MoveDirection.MoveDirectionUp || direction == MoveDirection.MoveDirectionDown {
                    return;
                }
            }else if direction == MoveDirection.MoveDirectionLeft || direction == MoveDirection.MoveDirectionRight{
                    return;
            }
           
        }
    }
    var moveFinishBlock:MoveFinish!//点击圆饼的index的block
    
    
    class func snake() -> (Snake) {
        let snake = Snake();
        snake.initBody();
        return snake;
    }
    
    func initBody() -> () {
        self.nodes .removeAllObjects();
        for i in 0...4 {
//            print("idx =\(idx)");
            let point = CGPoint.init(x: Double(NODEWH) * (Double(i) + 0.5), y: Double(NODEWH) * 0.5);
            self.nodes.add(Node.nodeWithCoordinate(coordinate: point));
        }
        self.direction = MoveDirection.MoveDirectionRight;
    }
    
    
    func levelUpWithSpeed(speed:NSInteger) -> () {
        self.speed = speed;
        self.pause();
        self.start();
    }
    
    func reset() -> () {
        self.initBody();
        self.speed = 0;
        self.start();
    }
    func start() -> () {
        let time:Float = Float(0.2 - Double(self.speed) * 0.02);
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(time), target: self, selector: #selector(move), userInfo: nil, repeats: true);
    }
    func pause() -> () {
        self.timer.invalidate();
//        self.timer = nil;
    }
    
   
    func growUp() -> () {
         let node = Node.nodeWithCoordinate(coordinate: self.lastPoint);
         self.nodes.add(node);
    }
    
    
    
    @objc func move() -> () {
        let node:Node = self.nodes.lastObject as! Node;
        self.lastPoint = node.coordinate;
        let lastNode:Node = self.nodes.firstObject as! Node;
        var center:CGPoint = lastNode.coordinate;
        switch self.direction {
        case .MoveDirectionUp:
            center.y -= CGFloat(NODEWH);
        case .MoveDirectionLeft:
            center.x -= CGFloat(NODEWH);
        case .MoveDirectionDown:
            center.y += CGFloat(NODEWH);
        case .MoveDirectionRight:
            center.x += CGFloat(NODEWH);
        default:
            break;
        }
        node.coordinate = center;
        self.nodes .removeAllObjects();
        self.nodes .insert(node, at: 0);
        if(self.moveFinishBlock != nil) {
            self.moveFinishBlock!(0);
        }
        print("查看time是否在执行");
    }
//    func nodeWithCoordinate(coordinate:CGPoint) -> sfntInstance {
//        let node = Node();
//         node.coordinate = coordinate;
//        return node;
//    }
    
}

