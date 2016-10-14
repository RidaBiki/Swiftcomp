//
//  SkillTableViewCell.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/14/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    // MARK: Properties
    

    @IBOutlet weak var SkillLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
