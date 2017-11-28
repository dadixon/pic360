//
//  DashboardViewController.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/12/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: BaseViewController {

    @IBOutlet weak var propertyItemTable: UITableView!
    
    private var sectionTitle = [String]()
    private var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        propertyItemTable.dataSource = self
        propertyItemTable.delegate = self
        
        propertyItemTable.tableFooterView = UIView()
        
        displayWalkthrough()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        sectionTitle = LibraryAPI.sharedInstance.getLocations().sorted()
        propertyItemTable.reloadData()
    }
    
    func setupNavBar() {
        title = "Dashboard"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    func displayWalkthrough() {
        let userDefault = UserDefaults.standard
        let displayWalkthrough = userDefault.bool(forKey: "initial")
        
//        if !displayWalkthrough {
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "InstructionViewController") {
                self.present(pageViewController, animated: true, completion: nil)
            }
//        }
    }
    
    
    // MARK: Actions
    
    @IBAction func addLocation(_ sender: Any) {
        let alertController = UIAlertController(title: "New Location", message: "Enter the name of the new location", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            let location = alertController.textFields?[0].text
            
            LibraryAPI.sharedInstance.addLocation(location!)
            self.sectionTitle = LibraryAPI.sharedInstance.getLocations().sorted()
            self.propertyItemTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc = segue.destination as! DetailViewController
            
            vc.location = sectionTitle[index]
        }
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
    }
}

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = sectionTitle[indexPath.row]
        cell.detailTextLabel?.text = "\(LibraryAPI.sharedInstance.getLocationAmount(sectionTitle[indexPath.row])) images"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
