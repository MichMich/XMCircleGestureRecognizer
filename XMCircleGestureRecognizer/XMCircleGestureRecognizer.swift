//
//  XMCircleGestureRecognizer.swift
//  XMCircleGestureRecognizer
//
//  Created by Michael Teeuw on 20-06-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

let π = Float(M_PI)

extension CGFloat {
    var degrees:Float {
        return self * 180 / π;
    }
    var radians:Float {
        return self * π / 180;
    }
    var rad2deg:Float {
        return self.degrees
    }
    var deg2rad:Float {
        return self.radians
    }

}

class XMCircleGestureRecognizer: UIGestureRecognizer {
    
    /* PUBLIC VARS */
    
    // midpoint for gesture recognizer
    var midPoint = CGPointZero
    
    // minimal distance from midpoint
    var innerRadius:CGFloat?
    
    // maximal distance to midpoint
    var outerRadius:CGFloat?
    
    // relative rotation for current gesture (in radians)
    var rotation:CGFloat? {
        if let currentPoint = self.currentPoint {
            if let previousPoint = self.previousPoint {
                var rotation = angleBetween(currentPoint, andPointB: previousPoint)
                
                if (rotation > π) {
                    rotation -= π*2
                } else if (rotation < -π) {
                    rotation += π*2
                }
                
                return rotation
            }
        }
        
        return nil
    }
    
    // absolute angle for current gesture (in radians)
    var angle:CGFloat? {
        if let nowPoint = self.currentPoint {
            return self.angleForPoint(nowPoint)
        }
    
        return nil
    }
    
    // distance from midpoint
    var distance:CGFloat? {
        if let nowPoint = self.currentPoint {
            return self.distanceBetween(self.midPoint, andPointB: nowPoint)
        }
    
        return nil
    }
    
    /* PRIVATE VARS */
    
    // internal usage for calculations. (Please give us Access Modifiers, Apple!)
    var currentPoint:CGPoint?
    var previousPoint:CGPoint?
    
    /* PUBLIC METHODS */
    
    // designated initializer
    init(midPoint:CGPoint, innerRadius:CGFloat?, outerRadius:CGFloat?, target:AnyObject?, action:Selector) {
        super.init(target: target, action: action)
        
        self.midPoint = midPoint
        self.innerRadius = innerRadius
        self.outerRadius = outerRadius
    }
   
    // convinience initializer if innerRadius and OuterRadius are not necessary
    convenience init(midPoint:CGPoint, target:AnyObject?, action:Selector) {
        self.init(midPoint:midPoint, innerRadius:nil, outerRadius:nil, target:target, action:action)
    }
    
    
    /* PRIVATE METHODS */
    
    func distanceBetween(pointA:CGPoint, andPointB pointB:CGPoint) -> CGFloat {
        let dx = pointA.x - pointB.x
        let dy = pointA.y - pointB.y
        return sqrtf(dx*dx + dy*dy)
    }
    
    func angleForPoint(point:CGPoint) -> CGFloat {
        var angle = -atan2f(point.x - midPoint.x, point.y - midPoint.y) + π/2

        if (angle < 0) {
            angle += π*2;
        }
        
        return angle
    }

    func angleBetween(pointA:CGPoint, andPointB pointB:CGPoint) -> CGFloat {
        return angleForPoint(pointA) - angleForPoint(pointB)
    }
    
    /* SUBCLASSED METHODS */
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        super.touchesBegan(touches, withEvent: event)
        
        currentPoint = touches.anyObject().locationInView(self.view)
        
        var newState:UIGestureRecognizerState = .Began
    
        if let innerRadius = self.innerRadius {
            if distance < innerRadius {
                newState = .Failed
            }
        }
        
        if let outerRadius = self.outerRadius {
            if distance > outerRadius {
                newState = .Failed
            }
        }
        
        state = newState

    }

    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        
        super.touchesMoved(touches, withEvent: event)
        
        if state == .Failed {
            return
        }
        
        currentPoint = touches.anyObject().locationInView(self.view)
        previousPoint = touches.anyObject().previousLocationInView(self.view)
        
        state = .Changed
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesEnded(touches, withEvent: event)
        state = .Ended
        
        currentPoint = nil
        previousPoint = nil
    }
    
}
