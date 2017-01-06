//
//  CategoryView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

protocol CategoryViewDelegate: AnyObject {
    func itemSelected(sender: Item)
}

class CategoryView: UIView {

    weak var categoryDel: CategoryViewDelegate!
    
    @IBOutlet var itemList: UITableView!
    
    var activeCategory: Int!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //set up the nib
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "CategoryView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //table setup
        self.itemList.register(UITableViewCell.self, forCellReuseIdentifier: "CHANGEME")
        self.itemList.dataSource = self
        self.itemList.delegate = self
    }
}

//table view extensions
extension CategoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = AppDelegate.getInstance().realm!
        let category = realm.objects(Category.self)[activeCategory]
        return category.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        let realm = AppDelegate.getInstance().realm!
        let category = realm.objects(Category.self)[activeCategory]

        cell.textLabel?.text = category.items[indexPath.row].itemName
        return cell
    }
}

extension CategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let selectedRow = itemList.indexPathForSelectedRow?.row
            else {return}
        let realm = AppDelegate.getInstance().realm!
        let category = realm.objects(Category.self)[activeCategory]
        let item = category.items[selectedRow]
        categoryDel.itemSelected(sender: item)
    }
}
