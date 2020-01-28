//
//  WarungTableViewCell.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 28/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import UIKit

class WarungTableViewCell: UITableViewCell {
    
    @IBOutlet weak var warungImageView: UIImageView!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var warungNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
