//
//  SetTargetViewController.swift
//  DrinkMe
//
//  Created by Fannisa Rahmah on 28/04/22.
//

import UIKit

protocol SetTargetDelegate: NSObjectProtocol {
    func setTarget(data: Int)
}

class SetTargetViewController: UIViewController {

    weak var delegate: SetTargetDelegate?
    var tempData: String?
    
    @IBOutlet weak var setTargetTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargetTF.text = tempData
    }
    
    @IBAction func backPressedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressedButton(_ sender: Any) {
        delegate?.setTarget(data: Int(setTargetTF.text ?? "") ?? 0)
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
