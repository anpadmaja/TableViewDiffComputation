//
//  VeniceBadge.swift
//  consumervenice
//
//  Created by Ika, Joan on 6/6/16.
//  Copyright © 2016 PayPal. All rights reserved.
//

import UIKit

@IBDesignable public class VeniceBadge: UILabel {
  
  static let defaultBackgroundColor: UIColor = .red
  
  enum BadgeStyle {
    case label, superscript
  }
  
  enum BadgeSize {
    case defaultSize
  }
  
  private var badgeStyle: BadgeStyle = .label
  
  @IBInspectable public var badgeBackgroundColor: UIColor = VeniceBadge.defaultBackgroundColor
  
  var badgeSize: BadgeSize = .defaultSize
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  open func updateBadgeCount(badgeText: String) {
    text = badgeText
  }
  
  private func setup() {
    textAlignment = NSTextAlignment.center
    baselineAdjustment = .alignCenters
    adjustsFontSizeToFitWidth = true
  }
  
  public convenience init(parentView: UIView, badgeText: String, badgeFont: UIFont = UIFont.systemFont(ofSize: 10), badgeTextColor: UIColor = .white) {
    self.init(frame: parentView.frame)
    parentView.addSubview(self)
    parentView.clipsToBounds = false
    badgeStyle = .superscript
    text = badgeText
    font = badgeFont
    textColor = badgeTextColor
  }
  
  public override func draw(_ rect: CGRect) {
    layer.cornerRadius = rect.height / 2
    let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2)
    badgeBackgroundColor.setFill()
    path.fill()
    
    super.draw(rect)
  }
  
  public override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)))
  }
  
  public override var intrinsicContentSize: CGSize {
    var intrinsicSize = super.intrinsicContentSize
    let topInset: CGFloat = 2
    let bottomInset: CGFloat = 4
    let leftInset: CGFloat = 8.5
    let rightInset: CGFloat = 8.5
    intrinsicSize.height += topInset + bottomInset
    intrinsicSize.width += leftInset + rightInset
    
    // In some cases, the badge can have a lower width than its height, leaving
    // the badge to be slightly misshapen. This ensures that the badge's width
    // is always enough to ensure that the badge is circular.
    if intrinsicSize.width < intrinsicSize.height {
      intrinsicSize.width = intrinsicSize.height
    }
    
    return intrinsicSize
  }
  
  public override func layoutSubviews() {
    if badgeStyle == .superscript {
      guard let parentView = superview else {
        assertionFailure("Should have a parent view")
        return
      }
      
      // some offset otherwise badge looks like its floating on top
      let offset = CGFloat(2)
      
      let badgeSize = getBadgeSize()
      // calculate new frame
      // get top right point of parent view, it will become center point of new frame -/+ offset
      let topRightPoint = CGPoint(x: parentView.bounds.size.width, y: 0)
      let badgeNewFrame = CGRect(x: topRightPoint.x - badgeSize.width/2 - offset,
                                 y: topRightPoint.y - badgeSize.height/2 + offset,
                                 width: badgeSize.width,
                                 height: badgeSize.height)
      
      frame = badgeNewFrame
    }
    
    super.layoutSubviews()
  }
  
  func getBadgeSize() -> CGSize {
    switch badgeSize {
    case .defaultSize:
      return CGSize(width: 16, height: 16)
    }
  }
}
