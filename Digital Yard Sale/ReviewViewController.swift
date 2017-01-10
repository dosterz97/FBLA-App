/*
 ReviewViewController.swift
 Displays the view for the review page given by the nib
 and handles any transitions to other view controllers from this page
 */

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var reviewView: ReviewView!
    
    var item: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewView.activeItem = item
        self.navigationItem.title = "Comments"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //show the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ReviewViewController: ItemViewControllerDelegate {
    func commentButtonClicked(sender: Int) {
        item = sender
    }
}
