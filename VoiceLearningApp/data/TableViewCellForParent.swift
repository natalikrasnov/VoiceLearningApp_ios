//
//  TableViewCellForParent.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 04/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit

class TableVieCellForParent: UITableViewCell {

    @IBOutlet weak var dateLAble: UILabel!
    @IBOutlet weak var eventLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
