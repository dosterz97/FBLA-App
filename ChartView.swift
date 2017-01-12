//
//  ChartView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/10/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import Foundation
import UIKit
import GLKit

class ChartView: UIView {
    
    var circleLayer: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let myGreen = UIColor(colorLiteralRed: 27/255, green: 123/255, blue: 70/255, alpha: 1)

        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = myGreen.cgColor
        circleLayer.lineWidth = 50.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to the precent of the goal
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let precent = appDelegate.money! / 10000
        animation.fromValue = 0
        animation.toValue = precent
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = CGFloat(precent)
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    //set up the nib
    func setupView() {
        //nib initialization
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "ChartView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        addSubview(view)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2.0, y: height / 2.0)
    }
}
