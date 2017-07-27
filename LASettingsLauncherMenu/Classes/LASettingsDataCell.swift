//
//  LASettingsLauncherMenuModel.swift
//  LASettingsLauncherMenu
//
//  Created by Luis Arias on 7/27/17.
//

import UIKit

public struct LASettingsLauncherMenuModel {
  
  public var title: String
  public var image: UIImage?
  
  public init(title: String, image: UIImage?) {
    self.title = title
    self.image = image
  }
}
