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
    var currentValue:Float = 0.0 {
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
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }

    
    func rotateGesture(recognizer:XMCircleGestureRecognizer)
    {
        feedbackLabel.text = ""
        
        if let rotation = recognizer.rotation {
            currentValue += rotation.rad2deg / 360 * 100
            feedbackLabel.text = feedbackLabel.text + String(format:"Value: %.2f%%", currentValue)
        }
        
        if let angle = recognizer.angle {
            feedbackLabel.text = feedbackLabel.text + "\n" + String(format:"Angle: %.2f%", angle.rad2deg)
        }
        
        if let distance = recognizer.distance {
            feedbackLabel.text = feedbackLabel.text + "\n" + String(format:"Distance: %.0f%", distance)
        }
    }
    

}

