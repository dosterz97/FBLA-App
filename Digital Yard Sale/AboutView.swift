//
//  AboutView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class AboutView: UIView {
    
    weak var aboutDelegate: MainViewDelegate!
    
    //required initializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //setup the view
    func setupView() {
        //basic nib initalization
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "AboutView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
}
