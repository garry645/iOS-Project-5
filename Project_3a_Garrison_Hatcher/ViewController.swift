//
//  ViewController.swift
//  Project_3a_Garrison_Hatcher
//
//  Created by Garrison Hatcher on 7/12/20.
//  Copyright © 2020 Garrison Hatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var newItemTF: UITextField!
    
    var pickerData: [String] = [String]()
    
    var selectedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["Thing One", "Thing Two", "Thing Three"]
        selectedData = pickerData[0]
    }

    @IBAction func selectPickerData(_ sender: Any) {
        let title = getTitle()
        createAlert(title: title, message: selectedData ?? "")
    }
    
    @IBAction func insertNewElement(_ sender: Any) {
        let elementToInsert = newItemTF.text ?? ""
        let currentIndex = picker.selectedRow(inComponent: 0)
        if(pickerData[0] == "" && pickerData.count == 1) {
            pickerData[0] = elementToInsert
        } else {
            pickerData.insert(elementToInsert, at: currentIndex + 1)
        }
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.selectRow(currentIndex + 1, inComponent: 0, animated: true)
        selectedData = elementToInsert
    }
    
    @IBAction func replaceElement(_ sender: Any) {
        let newElement = newItemTF.text ?? ""
        let currentIndex = picker.selectedRow(inComponent: 0)
        pickerData[currentIndex] = newElement
        picker.dataSource = self
        selectedData = newElement
    }
    
    @IBAction func deleteElement(_ sender: Any) {
        let currentIndex = picker.selectedRow(inComponent: 0)
        if(pickerData.count == 1) {
            pickerData[0] = ""
        } else {
            pickerData.remove(at: currentIndex)
        }
        picker.dataSource = self
        if(currentIndex == 0) {
            selectedData = ""
        } else {
            selectedData = pickerData[currentIndex - 1]
        }
    }
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Wow so cool", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTitle() -> String {
        if(selectedData == "") {
            return "Oh man it's empty"
        }
        if(picker.selectedRow(inComponent: 0) == 0) {
            return "It's just lazy picking the first item"
        } else if(picker.selectedRow(inComponent: 0) % 2 == 1) {
            return "Could have chosen a bit better"
        } else { return "Excellent Choice!" }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerData.count != 0) {
            selectedData = pickerData[row]
        } else {
            selectedData = nil
        }
    }
    
    
    

    
}
