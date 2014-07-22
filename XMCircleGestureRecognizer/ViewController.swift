//
//  ViewController.swift
//  XMCircleGestureRecognizer
//
//  Created by Michael Teeuw on 20-06-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var feedbackLabel = UILabel(frame: CGRectZero)
    var currentValue:CGFloat = 0.0 {
        didSet {
            if (currentValue > 100) {
                currentValue = 100
            }
            if (currentValue < 0) {
                currentValue = 0
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //add gesture recognizer
        self.view.addGestureRecognizer(XMCircleGestureRecognizer(midPoint: self.view.center, target: self, action: "rotateGesture:"))
        
        //add feedbackLabel
        feedbackLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(feedbackLabel)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|", options: nil, metrics: nil, views: ["view":feedbackLabel]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[view]-|", options: nil, metrics: nil, views: ["view":feedbackLabel]))

        feedbackLabel.textAlignment = .Center
        feedbackLabel.numberOfLines = 0;
        feedbackLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
    }

    
    func rotateGesture(recognizer:XMCircleGestureRecognizer)
    {
        feedbackLabel.text = ""
        
        if let rotation = recognizer.rotation {
            currentValue += rotation.degrees / 360 * 100
            feedbackLabel.text = feedbackLabel.text + String(format:"Value: %.2f%%", Float(currentValue))
        }
        
        if let angle = recognizer.angle {
            feedbackLabel.text = feedbackLabel.text + "\n" + String(format:"Angle: %.2f%", Float(angle.degrees))
        }
        
        if let distance = recognizer.distance {
            feedbackLabel.text = feedbackLabel.text + "\n" + String(format:"Distance: %.0f%", Float(distance))
        }
    }
    

}

