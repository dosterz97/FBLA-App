//
//  ShopView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/26/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

class ShopView: UIView, NavbarDelegate {
    
    @IBOutlet var navbar: Navbar!
    
    @IBOutlet var categoryList: UITableView!
    
    weak var shopDelegate: MainViewDelegate!
    
    var categories = [Category]()
    
    //needed initializers
    override init(frame aFrame: CGRect){
        super.init(frame:aFrame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupView()
        navbar.navDelegate = self
    }
    
    //set up the nib
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "ShopView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //table setup
        self.categoryList.register(UITableViewCell.self, forCellReuseIdentifier: "CHANGEME")
        self.categoryList.dataSource = self
        self.categoryList.delegate = self
        
        //setup the categoies data
        if (categories.count == 0) {
            let t = Category(nameT: "Clothes", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            categories.append(t)
            let u = Category(nameT: "Toys", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            categories.append(u)
            let v = Category(nameT: "Games", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            categories.append(v)
            let w = Category(nameT: "Other", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            categories.append(w)
        }
    }
    
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            print("home button has been selected")
            shopDelegate.navbarButtonPressed(sender: "ShopToHomeSegueID")
        }
        //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            print("shop button has been selected")
            //do nothing
        }
        //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            print("cart button has been selected")
            shopDelegate.navbarButtonPressed(sender: "ShopToCartSegueID")
        }
        //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            print("about button has been selected")
            shopDelegate.navbarButtonPressed(sender: "ShopToAboutSegueID")
        }
    }
}

//table view extensions
extension ShopView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}

extension ShopView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            (tableView.indexPathForSelectedRow?.row) != nil
            else {return}
    }
}