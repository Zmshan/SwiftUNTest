//
//  Node.swift
//  TestSwift
//
//  Created by open-roc on 2019/11/15.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
let NODEWH = 10
class Node: NSObject {
    var coordinate = CGPoint();
    class func nodeWithCoordinate(coordinate:CGPoint) -> Node {
        let node = Node();
         node.coordinate = coordinate;
        return node;
    }
}
