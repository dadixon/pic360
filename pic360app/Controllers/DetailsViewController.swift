//
//  DetailsViewController.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/25/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var propertyItemID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
        self.view.backgroundColor = UIColor.green

        let propertyItem = LibraryAPI.sharedInstance.getPropertyItemById(propertyItemID)
        
        imageView.image = getImage(imageName: propertyItem.imgName)
        nameLabel.text = propertyItem.name
        descriptionTextView.text = propertyItem.desc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func setupNavBar() {
        navigationItem.title = "Details"
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    func getImage(imageName: String) -> UIImage {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        } else {
            print("Panic! No Image!")
            return UIImage()
        }
    }
}
