//
//  PaymentViewController.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/9/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//


import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet var paymentView: PaymentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
