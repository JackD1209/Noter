//
//  NoteCell.swift
//  Noter
//
//  Created by Đoàn Minh Hoàng on 5/7/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
