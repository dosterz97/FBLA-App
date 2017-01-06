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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        let realm = AppDelegate.getInstance().realm!
        
        var user = User()
        //Add the item to the cart
        try! realm.write {
            let users = realm.objects(User.self);
            user = users[userNum!]
        }

        if (userComment.hasText) {
            let t = Review(reviewerT: user.username, reviewT: (userComment.attributedText?.string)!)
            activeItem.reviews.append(t)
            commentList.reloadData()
        }
    }
}

//table view extensions
extension ReviewView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeItem.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHANGEME", for: indexPath)
        cell.textLabel?.text = activeItem.reviews[indexPath.row].review.description
        return cell
    }
}

extension ReviewView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do nothing
    }
}
