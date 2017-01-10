//
//  ChartView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/10/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import Foundation
import UIKit

class ChartView: UIView {
    
    override init(frame aFrame:CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
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
