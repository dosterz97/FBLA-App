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
    
    var activeCategory: Category!
    
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
        self.itemList.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.itemList.dataSource = self
        self.itemList.delegate = self
        
        itemList.rowHeight = 150
    }
}

//table view extensions
extension CategoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = AppDelegate.getInstance().realm!
        let categories = realm.objects(Category.self)
        var category: Category!
        for i in 0..<categories.count {
            if(categories[i].name == activeCategory.name) {
                category = categories[i]
            }
        }
        return category.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        //open up the database
        let realm = AppDelegate.getInstance().realm!
        let categories = realm.objects(Category.self)
        var category: Category!
        for i in 0..<categories.count {
            if(categories[i].name == activeCategory.name) {
                category = categories[i]
            }
        }

        //create the image view
        let imageView = cell.contentView.subviews.first {$0.tag == -1234} as? UIImageView  ?? {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.tag = -1234
            cell.addSubview(imageView)
            return imageView
            }()
        
        //apply the image to the image view and clear the background color of the cell
        let image = UIImage(named: category.items[indexPath.row].image)
        cell.backgroundColor = .clear
        imageView.image = image
        
        //Add the view behind the text
        let opacityView = UIView(frame: CGRect(x: 0, y: cell.frame.height/5, width: cell.frame.width, height: cell.frame.height * 0.6))
        opacityView.backgroundColor = .black
        opacityView.alpha = 0.6
        cell.addSubview(opacityView)
        cell.bringSubview(toFront: opacityView)
        
        //Add the label,style it, and bring to the front of the view
        let cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        cellLabel.text = category.items[indexPath.row].itemName
        cellLabel.font = cellLabel.font.withSize(40)
        cellLabel.textColor = .white
        cellLabel.textAlignment = .center
        cell.customLabel = cellLabel
        cell.addSubview(cellLabel)
        cell.bringSubview(toFront: cellLabel)
        return cell
    }
}

extension CategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let selectedRow = itemList.indexPathForSelectedRow?.row
            else {return}
        let realm = AppDelegate.getInstance().realm!
        let categories = realm.objects(Category.self)
        var category: Category!
        for i in 0..<categories.count {
            if(categories[i].name == activeCategory.name) {
                category = categories[i]
            }
        }
        self.itemList.deselectRow(at: indexPath, animated: true)
        let item = category.items[selectedRow]
        categoryDel.itemSelected(sender: item)
    }
}
