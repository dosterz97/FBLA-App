//
//  CartView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class CartView: UIView, NavbarDelegate {
    
    @IBOutlet var navbar: Navbar!
    
    @IBOutlet var cartList: UITableView!
    
    weak var cartDelegate: MainViewDelegate!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        navbar.navDelegate = self
    }
    
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "CartView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //table setup
        self.cartList.register(UITableViewCell.self, forCellReuseIdentifier: "CHANGEME")
        self.cartList.dataSource = self
        self.cartList.delegate = self
    }
    
    //when a navbar button is pressed, segue using the main view delegate
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            cartDelegate.navbarButtonPressed(sender: "CartToHomeSegueID")
        }
            //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            cartDelegate.navbarButtonPressed(sender: "CartToShopSegueID")
        }
            //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            //do nothing
        }
            //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            cartDelegate.navbarButtonPressed(sender: "CartToAboutSegueID")
        }

    }
}

//table view extensions
extension CartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var numberOfItems: Int
        numberOfItems = 0
        try! realm.write {
            let users = realm.objects(User.self);
            let user = users[userNum!]
            numberOfItems = user.userCart.count
            print(user.username)
        }
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)

        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        
        try! realm.write {
            let users = realm.objects(User.self);
            user = users[userNum!]
        }

        cell.textLabel?.text = user.userCart[indexPath.row].itemName
        return cell
    }
}

extension CartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let selectedRow = cartList.indexPathForSelectedRow?.row
            else {return}
    }
}
