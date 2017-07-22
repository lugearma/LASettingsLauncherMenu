//
//  LASettingsLauncherMenuCell.swift
//
//
//  Created by Luis Arias on 7/22/17.
//

import UIKit

public final class LASettingsLauncherMenuCell: UICollectionViewCell {
  
  static let identifier = "LASettingsLauncherMenuCell"
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .blue
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    
  }
}
