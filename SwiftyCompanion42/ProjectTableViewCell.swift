//
//  ProjectTableViewCell.swift
//  SwiftyCompanion42
//
//  Created by Rida BIKITARAN on 10/20/16.
//  Copyright © 2016 Rida BIKITARAN. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var ProjectLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    
    
    //MARK: Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
