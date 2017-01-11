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
    func categoryPressed(sender: Category)
}

class ShopView: UIView {
    
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
            
            let t = Category(nameT: "Clothes", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            let u = Category(nameT: "Toys", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            let v = Category(nameT: "Games", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            let w = Category(nameT: "Other", picURLT: "https://s-media-cache-ak0.pinimg.com/564x/01/ac/f3/01acf35b1708f85f937c57a195fe31b7.jpg")
            
            let a = Item(itemNameT: "Jordans", itemDescriptionT: "Cool Shoes", priceT: 20, conditionRatingT: 3, categoryT: t, picURL: "http://images.footlocker.com/pi/23581001/zoom/jordan-horizon-mens")
            t.items.append(a)
            let b = Item(itemNameT: "two", itemDescriptionT: "", priceT: 0, conditionRatingT: 5, categoryT: t, picURL: "http://images.footlocker.com/pi/23581001/zoom/jordan-horizon-mens")
            t.items.append(b)
            
            try! realm.write {
                realm.add(t)
                realm.add(u)
                realm.add(v)
                realm.add(w)
                
            }
        }
    }

}

//table view extensions
extension ShopView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = AppDelegate.getInstance().realm!
        
        let categoryList = realm.objects(Category.self)

        return categoryList.count//Number of categories in realm
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        let realm = AppDelegate.getInstance().realm!
        let categoryList = realm.objects(Category.self)

        cell.textLabel?.text = categoryList[indexPath.row].name//Set the text for each cell
        return cell
    }
}

extension ShopView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            (categoryTable.indexPathForSelectedRow?.row) != nil
            else {return}
        let realm = AppDelegate.getInstance().realm!
        let categoryList = realm.objects(Category.self)
        self.categoryTable.deselectRow(at: indexPath, animated: true)
        categoryDelegate.categoryPressed(sender: categoryList[indexPath.row])//Move to category page based on indexRow
    }
}
