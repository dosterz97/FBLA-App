//
//  ReviewView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 1/6/17.
//  Copyright © 2017 Zachary Doster. All rights reserved.
//

import UIKit
import RealmSwift

class ReviewView: UIView {
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var commentList: UITableView!
    
    @IBOutlet var userComment: UITextField!
    
    var activeItem: Item!
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "ReviewView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //setup table data
        self.commentList.register(UITableViewCell.self, forCellReuseIdentifier: "CHANGEME")
        self.commentList.dataSource = self
        self.commentList.delegate = self
        
        submitButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)
    }
    
    //adds a comment to the lis
    func addComment() {
        print(activeItem)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        let realm = AppDelegate.getInstance().realm!
        
        var user = User()//The current user
        var item = Item()//The item to add the comment to
        //Add the item to the cart
        
        let users = realm.objects(User.self)
        user = users[userNum!]
        let items = realm.objects(Item.self)
        
        for tempItem in items {
            if (tempItem.itemName == activeItem.itemName) {
                item = tempItem
            }
        }
        //Add the comment to the list
        if (userComment.hasText) {
            let t = Review(reviewerT: user.username, reviewT: (userComment.attributedText?.string)!)
            try! realm.write {
                item.reviews.append(t)
            }
            commentList.reloadData()
        }
    }
}

//table view extensions
extension ReviewView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = AppDelegate.getInstance().realm!

        let items = realm.objects(Item.self)
        //find the item
        for item in items {
            if (item.itemName == activeItem.itemName) {
                return item.reviews.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        
        let realm = AppDelegate.getInstance().realm!
        let items = realm.objects(Item.self)
        //find the item
        for item in items {
            if (item.itemName == activeItem.itemName) {
                cell.textLabel?.text = item.reviews[indexPath.row].review.description

            }
        }
        return cell
    }
}

extension ReviewView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do nothing
    }
}
