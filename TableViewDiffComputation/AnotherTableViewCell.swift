//
//  AnotherTableViewCell.swift
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 4/25/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

import UIKit

protocol Badgeable {
  var color: UIColor { get set }
  var badgeSize: CGFloat { get set }
  var isVisible: Bool {get set}
}

class AnotherTableViewCell: UITableViewCell, Badgeable {
  var color: UIColor = UIColor.blue
  var badgeSize: CGFloat = 25
  var isVisible: Bool = false
  
  @IBOutlet weak var cellTitle: UILabel!
  
  @IBOutlet weak var anchorImage: UIImageView! {
    didSet {
      anchorImage.backgroundColor = color
      anchorImage.layer.cornerRadius = anchorImage.frame.height/2
    }
  }
  
  override func layoutSubviews() {
    if isVisible {
      anchorImage.isHidden  = true
    }
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
        // Initialization code
  }
  
  func configure(name: String) {
    cellTitle.text = name
    isVisible = true
  }
}
