//
//  ViewController.swift
//  XMCircleGestureRecognizer
//
//  Created by Michael Teeuw on 20-06-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var feedbackLabel = UILabel(frame: CGRect.zero)
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
        self.view.addGestureRecognizer(XMCircleGestureRecognizer(midPoint: self.view.center, target: self, action: #selector(ViewController.rotateGesture(recognizer:))))
        
        //add feedbackLabel
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(feedbackLabel)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: ["view":feedbackLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: [], metrics: nil, views: ["view":feedbackLabel]))

        feedbackLabel.textAlignment = .center
        feedbackLabel.numberOfLines = 0;
        feedbackLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        feedbackLabel.text = "Perform a gesture here."
    }

    
    func rotateGesture(recognizer:XMCircleGestureRecognizer)
    {
        feedbackLabel.text = ""
        
        if let rotation = recognizer.rotation {
            currentValue += rotation.degrees / 360 * 100
            feedbackLabel.text = feedbackLabel.text! + String(format:"Value: %.2f%%", currentValue)
        }
        
        if let angle = recognizer.angle {
            feedbackLabel.text = feedbackLabel.text! + "\n" + String(format:"Angle: %.2f%", angle.degrees)
        }
        
        if let distance = recognizer.distance {
            feedbackLabel.text = feedbackLabel.text! + "\n" + String(format:"Distance: %.0f%", distance)
        }
    }
    

}

