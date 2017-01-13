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
        self.categoryTable.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.categoryTable.dataSource = self
        self.categoryTable.delegate = self
        
        categoryTable.rowHeight = 150
        
        //set up the list content
        giveListsContent()
    }
    
    func giveListsContent() {
        let realm = AppDelegate.getInstance().realm!
        
        //all categories from the realm
        let categoryList = realm.objects(Category.self)
        
        //setup the categories data
        if (categoryList.count < 2) {
            
            let clothes = Category(nameT: "Clothes", picURLT: "clothes.jpg")
            let toys = Category(nameT: "Toys", picURLT: "toys.jpeg")
            let games = Category(nameT: "Games", picURLT: "games.jpeg")
            let other = Category(nameT: "Other", picURLT: "other.jpeg")
            
            var item = Item()
            
            //Clothes
            item = Item(itemNameT: "Jordans", itemDescriptionT: "\"Cool Shoes\"- Micheal Jordan", priceT: 35, conditionRatingT: 3, categoryT: clothes, image: "jordans.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Sketchers", itemDescriptionT: "They light up!", priceT: 25, conditionRatingT: 4, categoryT: clothes, image: "sketchers.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Blue Shirt", itemDescriptionT: "A blue shirt.", priceT: 20, conditionRatingT: 2, categoryT: clothes, image: "blueshirt.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Tutu", itemDescriptionT: "From my sisters ballet.", priceT: 5, conditionRatingT: 5, categoryT: clothes, image: "tutu.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Grey Sweater", itemDescriptionT: "Grey long-sleeved shirt.", priceT: 50, conditionRatingT: 5, categoryT: clothes, image: "greysweater.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Crazy Socks", itemDescriptionT: "Orange Socks with Animals on it.", priceT: 20, conditionRatingT: 4, categoryT: clothes, image: "crazysocks.jpg")
            clothes.items.append(item)
            item = Item(itemNameT: "Black Jersey", itemDescriptionT: "Old soccer jersey.", priceT: 20, conditionRatingT: 4, categoryT: clothes, image: "blackjeresey.jpg")//yes i know thats not how it's spelled
            clothes.items.append(item)
            item = Item(itemNameT: "Sweatpants", itemDescriptionT: "Adidas Sweatpants", priceT: 35, conditionRatingT: 5, categoryT: clothes, image: "sweatpants.jpg")
            clothes.items.append(item)
            
            //Toys
            item = Item(itemNameT: "Basketball", itemDescriptionT: "Standard sized Spalding.", priceT: 35, conditionRatingT: 3, categoryT: toys, image: "basketball.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Nerf Gun", itemDescriptionT: "Comes with all pieces.", priceT: 25, conditionRatingT: 4, categoryT: toys, image: "nerfgun.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Rubik Cube", itemDescriptionT: "Missing one yellow sticker.", priceT: 20, conditionRatingT: 2, categoryT: toys, image: "rubikcube.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Lego Bucket", itemDescriptionT: "Big bucket of random Legos.", priceT: 5, conditionRatingT: 5, categoryT: toys, image: "legos.jpeg")
            toys.items.append(item)
            item = Item(itemNameT: "Soccer Ball", itemDescriptionT: "Standard 5 size.", priceT: 50, conditionRatingT: 5, categoryT: toys, image: "soccerball.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Lacrosse Pads", itemDescriptionT: "Large, comes with mask.", priceT: 20, conditionRatingT: 4, categoryT: toys, image: "lacrosse.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Star Wars Action Figures", itemDescriptionT: "6 figures.", priceT: 20, conditionRatingT: 4, categoryT: toys, image: "actionfigures.jpg")
            toys.items.append(item)
            item = Item(itemNameT: "Batman Boomerangs", itemDescriptionT: "Lightly scratched from use.", priceT: 35, conditionRatingT: 2, categoryT: toys, image: "batmanboomerang.jpg")
            toys.items.append(item)
            
            //Games
            item = Item(itemNameT: "PacMan", itemDescriptionT: "Comes with joystick.", priceT: 35, conditionRatingT: 3, categoryT: games, image: "pacman.jpeg")
            games.items.append(item)
            item = Item(itemNameT: "Forza", itemDescriptionT: "XBOX 360.", priceT: 35, conditionRatingT: 5, categoryT: games, image: "forza.jpeg")
            games.items.append(item)
            item = Item(itemNameT: "Jenga", itemDescriptionT: "All blocks present.", priceT: 20, conditionRatingT: 5, categoryT: games, image: "jenga.jpg")
            games.items.append(item)
            item = Item(itemNameT: "Sorry!", itemDescriptionT: "Missing one red piece.", priceT: 5, conditionRatingT: 2, categoryT: games, image: "sorry.jpg")
            games.items.append(item)
            item = Item(itemNameT: "LEGO Star Wars", itemDescriptionT: "All 3 games for XBOX 360.", priceT: 50, conditionRatingT: 5, categoryT: games, image: "legostarwars.jpg")
            games.items.append(item)
            item = Item(itemNameT: "Mario Kart", itemDescriptionT: "GameCube.", priceT: 20, conditionRatingT: 4, categoryT: games, image: "mariokart.jpg")
            games.items.append(item)
            item = Item(itemNameT: "Legend Of Zelda", itemDescriptionT: "GameCube.", priceT: 20, conditionRatingT: 4, categoryT: games, image: "zelda.jpg")
            games.items.append(item)
            item = Item(itemNameT: "Pokemon XD", itemDescriptionT: "Nintendo DS.", priceT: 35, conditionRatingT: 5, categoryT: games, image: "pokemonxd.jpeg")
            games.items.append(item)
            
            //Other
            item = Item(itemNameT: "Dirt Bike", itemDescriptionT: "Big Red.", priceT: 1500, conditionRatingT: 3, categoryT: other, image: "dirtbike.jpg")
            other.items.append(item)
            item = Item(itemNameT: "Portable Charger", itemDescriptionT: "It lights up!", priceT: 25, conditionRatingT: 2, categoryT: other, image: "portable charger.jpg")
            other.items.append(item)
            item = Item(itemNameT: "Desk Chair", itemDescriptionT: "Racer styled chair", priceT: 20, conditionRatingT: 5, categoryT: other, image: "deskchair.jpg")
            other.items.append(item)
            item = Item(itemNameT: "ITunes Gift Card $25", itemDescriptionT: "From Xmas, I use spotify.", priceT: 15, conditionRatingT: 5, categoryT: other, image: "itunes.jpg")
            other.items.append(item)
            item = Item(itemNameT: "Coupon Book", itemDescriptionT: "$100 value.", priceT: 50, conditionRatingT: 4, categoryT: other, image: "coupons.jpeg")
            other.items.append(item)
            item = Item(itemNameT: "Mountain Bike", itemDescriptionT: "Big Blue!", priceT: 120, conditionRatingT: 5, categoryT: other, image: "mountainbike.jpg")
            other.items.append(item)
            item = Item(itemNameT: "GameCube", itemDescriptionT: "Comes with 1 controller(blue).", priceT: 90, conditionRatingT: 4, categoryT: other, image: "gamecube.jpeg")
            other.items.append(item)
            item = Item(itemNameT: "XBOX 360", itemDescriptionT: "Comes with 1 controller(black).", priceT: 135, conditionRatingT: 5, categoryT: other, image: "xbox360.png")
            other.items.append(item)
            
            try! realm.write {
                realm.add(clothes)
                realm.add(toys)
                realm.add(games)
                realm.add(other)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        

        let realm = AppDelegate.getInstance().realm!
        let categoryList = realm.objects(Category.self)

        cell.customLabel?.text = categoryList[indexPath.row].name//Set the text for each cell
        cell.customLabel?.textColor = .white
        cell.customLabel?.textAlignment = .center
        
        
        let imageView = cell.contentView.subviews.first {$0.tag == -1234} as? UIImageView  ?? {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.tag = -1234
            cell.contentView.addSubview(imageView)
            
            return imageView
        }()
        
        print("why")
        cell.contentView.sendSubview(toBack: imageView)
        
        let image = UIImage(named: categoryList[indexPath.row].picURL)
        cell.backgroundColor = .clear
        imageView.image = image
        
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
