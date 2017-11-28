//
//  AddItemViewController.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/13/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit

class AddItemViewController: BaseViewController {

    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var location: String!
    var nameTextField: UITextField!
    var locationTextField: UITextField!
    var descTextField: UITextField!
    
    var imagePicker: UIImagePickerController!
    let locationPicker = UIPickerView()
    
    var locations = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        title = "Add Property Item"
        location = "Kitchen"
        
        locations = LibraryAPI.sharedInstance.getLocations().sorted()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveItem(_ sender: Any) {
        let name: String = nameTextField.text!
        let filename = "\(name)_\(NSDate().timeIntervalSince1970).jpg"
        if let data = UIImageJPEGRepresentation(imageView.image!, 1.0) {
            let filePath = getDocumentsDirectory().appendingPathComponent(filename)
            try? data.write(to: filePath)
            
            LibraryAPI.sharedInstance.addPropertyItem(name: nameTextField.text!, location: locationTextField.text!, imgPath: filename, description: descTextField.text!, serialNumber: "")
        
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension AddItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension AddItemViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputTableViewCell", for: indexPath) as! InputTableViewCell
        
        switch indexPath.row {
        case 0 :
            cell.configure(text: "Name", placeholder: "Required")
            nameTextField = cell.textField
            return cell
        case 1 :
            cell.configure(text: "Location", placeholder: "Required")
            locationTextField = cell.textField
            locationTextField.inputView = locationPicker
            locationPicker.delegate = self
            return cell
        case 2: cell.configure(text: "Comment", placeholder: "Optional")
            descTextField = cell.textField
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTextField.text = locations[row]
    }
}

extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
}

