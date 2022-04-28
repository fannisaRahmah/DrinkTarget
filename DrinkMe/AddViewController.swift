//
//  AddViewController.swift
//  DrinkMe
//
//  Created by Fannisa Rahmah on 27/04/22.
//

import UIKit

protocol AddViewDelegate: NSObjectProtocol {
    func passSchedule(data: DrinkSchedule)
    func updateData(data: DrinkSchedule, indexPath: Int)
}

class AddViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var targetTF: UITextField!
    
    weak var delegate: AddViewDelegate?
    var tempData: DrinkSchedule?
    var flag: Int?
    var position: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if flag == 1{
            navigationItem.title = "Add Schedule"
        }else{
            navigationItem.title = "Edit Schedule"
        }
        titleTF.text = tempData?.title ?? "New Schedule"
        targetTF.text = String(tempData?.target ?? 0)
    }
    
    @IBAction func backPressedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressedButton(_ sender: Any) {
        
        let data = DrinkSchedule(title: titleTF.text ?? "", target: Int(targetTF.text ?? "") ?? 0, time: timePicker.date, identifier: "testIdentifier")
        
        if flag == 0 {
            self.delegate?.updateData(data: data, indexPath: position ?? 0)
        } else {
            self.delegate?.passSchedule(data: data)
        }
            
        dismiss(animated: true, completion: nil)
    }
    
}
