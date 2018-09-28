//
//  PlaylistTableViewCell.swift
//  Music
//
//  Created by Shape on 26/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    
    // MARK: Variables
    @IBOutlet weak var listName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
