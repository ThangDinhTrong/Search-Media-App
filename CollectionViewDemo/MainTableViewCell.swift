//
//  MainTableViewCell.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/1/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var mainImageView : UIImageView!
    @IBOutlet var mainNameLabel:UILabel!
    @IBOutlet var mainArtistLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
