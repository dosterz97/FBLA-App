//
//  ShopView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/26/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

protocol ShopViewDelegate: AnyObject {
    func categoryPressed(sender: Int)
}

class ShopView: UIView, NavbarDelegate {
    
    @IBOutlet var navbar: Navbar!
    
    @IBOutlet var categoryTable: UITableView!
    
    weak var shopDelegate: MainViewDelegate!
    
    weak var categoryDelegate: ShopViewDelegate!
    
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
        self.categoryTable.register(UITableViewCell.self, forCellReuseIdentifier: "CHANGEME")
        self.categoryTable.dataSource = self
        self.categoryTable.delegate = self
        
        let realm = AppDelegate.getInstance().realm!
        
        //all categories from the realm
        let categoryList = realm.objects(Category.self)
        
        //setup the categories data
        if (categoryList.count < 1) {
            
            

            let itemsTemp = List<Item>()
            
            let t = Category(nameT: "Clothes", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg", itemsT: itemsTemp)
            let u = Category(nameT: "Toys", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg", itemsT: itemsTemp)
            let v = Category(nameT: "Games", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg", itemsT: itemsTemp)
            let w = Category(nameT: "Other", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg", itemsT: itemsTemp)
            let a = Item(itemNameT: "Jordans", itemDescriptionT: "The coolest used shoes", priceT: 20, conditionRatingT: 4, categoryT: t)
            t.items.append(a)
            let b = Item(itemNameT: "two", itemDescriptionT: "", priceT: 0, conditionRatingT: 5, categoryT: t)
            t.items.append(b)
            
            try! realm.write {
                realm.add(t)
                realm.add(u)
                realm.add(v)
                realm.add(w)
            }
        }
    }
    
    func navbarButtonPressed(sender: UIButton) {
        //home
        if (sender.tag == ButtonTags.home.rawValue) {
            shopDelegate.navbarButtonPressed(sender: "ShopToHomeSegueID")
        }
        //shop
        else if (sender.tag == ButtonTags.shop.rawValue) {
            //do nothing
        }
        //cart
        else if (sender.tag == ButtonTags.cart.rawValue) {
            shopDelegate.navbarButtonPressed(sender: "ShopToCartSegueID")
        }
        //about
        else if (sender.tag == ButtonTags.about.rawValue) {
            shopDelegate.navbarButtonPressed(sender: "ShopToAboutSegueID")
        }
    }
}

//table view extensions
extension ShopView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = AppDelegate.getInstance().realm!
        
        let categoryList = realm.objects(Category.self)

        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        let realm = AppDelegate.getInstance().realm!
        let categoryList = realm.objects(Category.self)

        cell.textLabel?.text = categoryList[indexPath.row].name
        return cell
    }
}

extension ShopView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            (categoryTable.indexPathForSelectedRow?.row) != nil
            else {return}
        
        categoryDelegate.categoryPressed(sender: indexPath.row)
    }
}
