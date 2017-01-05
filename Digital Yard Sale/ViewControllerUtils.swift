//
//  ViewControllerUtils.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

extension UIViewController {
    // This only works for MODAL view controllers in a static
    func dismissToRootPresenter() {
        var vc = self.presentingViewController
        
        while vc?.presentingViewController != nil {
            vc = vc?.presentingViewController
        }
        
        vc?.dismiss(animated: true, completion: nil)
    }
    
}
