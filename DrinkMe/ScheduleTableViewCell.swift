//
//  ScheduleTableViewCell.swift
//  DrinkMe
//
//  Created by Fannisa Rahmah on 27/04/22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var schViewCell: UIView!
    @IBOutlet weak var titleTVC: UILabel!
    @IBOutlet weak var targetTVC: UILabel!
    @IBOutlet weak var timeTVC: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
