//
//  MainScreenTableViewCell.swift
//  IKTestTask
//
//  Created by Kukshtel I. on 8/5/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import UIKit

final class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
    }

}
