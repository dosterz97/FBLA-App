//
//  CartView.swift
//  Digital Yard Sale
//
//  Created by Zachary Doster on 12/27/16.
//  Copyright © 2016 Zachary Doster. All rights reserved.
//

import UIKit

protocol CartToItemDelegate: AnyObject {
    func itemSelected(sender: Item)
    func checkOutPressed()
}

class CartView: UIView {
    
    @IBOutlet var cartList: UITableView!
    
    @IBOutlet var checkOutButton: UIButton!
    
    @IBOutlet var costLabel: UILabel!
    
    weak var cartDelegate: MainViewDelegate!
    
    weak var cartToItemDelegate: CartToItemDelegate!
    
    var itemsInCart: Bool?
    
    var total: Double?
    
    //required intializers
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func viewLoading() {
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID

        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            let users = realm.objects(User.self)
            user = users[userNum!]
        }
        
        if (user.userCart.count == 0) {
            checkOutButton.backgroundColor = .gray
            itemsInCart = false
        }
        else {
            let myGreen = UIColor(colorLiteralRed: 27/255, green: 123/255, blue: 70/255, alpha: 1)
            checkOutButton.backgroundColor = myGreen
            itemsInCart = true
        }
        
        total = 0
        //open the realm to find the user
        for item in user.userCart {
            total? += item.price
        }
        
        costLabel.text = "$0.00"
        if (total != 0) {
            //set the string of price to two places
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2

            let tempNum = NSNumber(value: total!)
            let temp = numberFormatter.string(from: tempNum)
            costLabel.text = "$" + temp!
        }
        cartList.reloadData()
        
    }
    
    func setupView() {
        //basic nib setup
        let bundle = Bundle(for: type(of:self))
        let nib = UINib.init(nibName: "CartView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        //table setup
        self.cartList.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.cartList.dataSource = self
        self.cartList.delegate = self
        self.cartList.rowHeight = 125
        
        self.checkOutButton.addTarget(self, action: #selector(checkOutPressed), for: .touchUpInside)
    }
    
    //move to the item page
    func checkOutPressed () {
        if(itemsInCart!) {
            cartToItemDelegate.checkOutPressed()
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
            let users = realm.objects(User.self)
            let user = users[userNum!]
            numberOfItems = user.userCart.count
        }
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        //open up the database
        let realm = AppDelegate.getInstance().realm!
        var user = User()
        try! realm.write {
            let users = realm.objects(User.self)
            user = users[userNum!]
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
        let image = UIImage(named: user.userCart[indexPath.row].image)
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
        cellLabel.text = user.userCart[indexPath.row].itemName
        cellLabel.font = cellLabel.font.withSize(40)
        cellLabel.textColor = .white
        cellLabel.textAlignment = .center
        cell.customLabel = cellLabel
        cell.addSubview(cellLabel)
        cell.bringSubview(toFront: cellLabel)
        return cell

    }
}

extension CartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            (cartList.indexPathForSelectedRow?.row) != nil
            else {return}
        
        //get the current user ID
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userNum = appDelegate.userID
        
        //open the realm to find the user
        let realm = AppDelegate.getInstance().realm!
        var item: Item!
        try! realm.write {
            let users = realm.objects(User.self)
            let user = users[userNum!]
            item = user.userCart[indexPath.row]
        }
        self.cartList.deselectRow(at: indexPath, animated: true)
        cartToItemDelegate.itemSelected(sender: item)
    }
}
