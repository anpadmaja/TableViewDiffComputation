//
//  AnotherTableViewCell.swift
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 4/25/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

import UIKit

class AnotherTableViewCell: UITableViewCell {
  var color: UIColor = UIColor.blue
  
  @IBOutlet weak var cellTitle: UILabel!
  
  @IBOutlet weak var anchorImage: UIImageView! {
    didSet {
      anchorImage.backgroundColor = color
      anchorImage.layer.cornerRadius = anchorImage.frame.height/2
    }
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
        // Initialization code
  }
  
  func configure(name: String) {
    cellTitle.text = name
  }
}
