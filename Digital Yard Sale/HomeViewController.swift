/*
HomeViewController.swift
Displays the view for the home page given by the nib
and handles any transitions to other view controllers from this page
*/

import UIKit

class HomeViewController: UIViewController, MainViewDelegate {
    
    @IBOutlet var homeView: HomeView!
    
    @IBOutlet var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.homeDelegate = self
        self.navigationItem.title = "Home"
        self.addCircleView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hide the navigation bar on this page
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        homeView.viewAppearing()
        
        addCircleView()
    }
    
    //the home view will give the segue ID upon type of button pressed
    func navbarButtonPressed(sender: String) {
        self.performSegue(withIdentifier: sender, sender: nil)
    }
    
    //home view segues to profile view
    func profileButtonPressed(sender: AnyObject) {
        self.performSegue(withIdentifier: "HomeToWelcomeSegueID", sender: nil)
    }
    
    func addCircleView() {
        let circleWidth = CGFloat(200)
        let circleHeight = circleWidth
        let size = self.homeView.bounds.size
        
        // Create a new CircleView
        let circleView = ChartView(frame: CGRect(x: size.width/2 - circleWidth/2, y: size.height/2 - circleHeight/2, width: circleWidth, height: circleHeight))
        
        view.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(duration: 1.0)
    }
}
