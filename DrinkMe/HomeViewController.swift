//
//  HomeViewController.swift
//  DrinkMe
//
//  Created by Fannisa Rahmah on 27/04/22.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, AddViewDelegate, SetTargetDelegate {
    
    func setTarget(data: Int) {
        setTargetLabel.setTitle(String(data) + " ml", for: .normal)
    }
    
    func updateData(data: DrinkSchedule, indexPath: Int) {
        models[indexPath] = data
        drinkScheduleTV.reloadData()
        sumTarget()
    }
    
    func passSchedule(data: DrinkSchedule) {
        models.append(data)
        drinkScheduleTV.reloadData()
        sumTarget()
    }
    
    @IBOutlet weak var totalTargetLabel: UILabel!
    @IBOutlet weak var drinkScheduleTV: UITableView!
    @IBOutlet weak var setTargetLabel: UIButton!
    
    var models = [DrinkSchedule]()
    var passingModel: DrinkSchedule?
    var flag: Int = 1
    var position: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: nil)
        
        drinkScheduleTV.register(nib, forCellReuseIdentifier: "ScheduleTableViewCell")
        
        drinkScheduleTV.delegate = self
        drinkScheduleTV.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAddVC" {
            let destVC = segue.destination as! UINavigationController
            let topVC = destVC.topViewController as! AddViewController
            topVC.delegate = self
            topVC.tempData = passingModel
            topVC.flag = self.flag
            topVC.position = self.position
            
        } else if segue.identifier == "ToSetVC" {
            let destVC = segue.destination as! UINavigationController
            let topVC = destVC.topViewController as!
                SetTargetViewController
            topVC.delegate = self
            topVC.tempData = setTargetLabel.currentTitle
        }
    }
    
    @IBAction func totalTargetButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSetVC", sender: self)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.models.removeAll()
        drinkScheduleTV.reloadData()
        sumTarget()
    }
    
    @IBAction func addPressedButton(_ sender: Any) {
        passingModel = nil
        flag = 1
        performSegue(withIdentifier: "ToAddVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if models[indexPath.row].isClicked == false {
            models[indexPath.row].isClicked = true
        } else {
            models[indexPath.row].isClicked = false
        }
        sumTarget()
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        models = models.sorted(by: { $0.time < $1.time})
        
        let time = models[indexPath.row].time
        let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        
        let isClicked = models[indexPath.row].isClicked
        
        let clickedColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00).cgColor
        let unclickedColor = UIColor(red: 0.37, green: 0.52, blue: 0.99, alpha: 1.00).cgColor
        cell.schViewCell.layer.backgroundColor = isClicked ? clickedColor : unclickedColor
        
        cell.titleTVC.textColor = isClicked ? .darkGray : .white
        cell.targetTVC.textColor = isClicked ? .darkGray : .white
        cell.timeTVC.textColor = isClicked ? .darkGray : .white
        
        cell.titleTVC.text = models[indexPath.row].title
        cell.targetTVC.text = "\(models[indexPath.row].target)" + " ml"
        cell.timeTVC.text = formatter.string(from: time)
        
        cell.schViewCell.layer.cornerRadius = 10
        
        return cell
    }
    
    // Delete + Edit Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .destructive, title: "Delete") { rowAction, indexPath in
            tableView.beginUpdates()
            
            self.models.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            self.sumTarget()
        }
        
        deleteButton.backgroundColor = UIColor.red
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { [self] rowAction, indexPath in
            passingModel = self.models[indexPath.row]
            flag = 0
            position = indexPath.row
            performSegue(withIdentifier: "ToAddVC", sender: self)
        }
        
        editButton.backgroundColor = UIColor.blue
        
        return [deleteButton,editButton]
    }
    
    func sumTarget() {
        var targetTemp: Int = 0
        
        for element in models {
            if element.isClicked {
                targetTemp += element.target
            }
        }
        totalTargetLabel.text = String(targetTemp)
    }
}

struct DrinkSchedule{
    let title: String
    let target: Int
    let time: Date
    let identifier: String
    var isClicked: Bool = false
}
