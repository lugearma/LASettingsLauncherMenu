//
//  ViewController.swift
//  LASettingsLauncherMenu
//
//  Created by lugearma on 07/22/2017.
//  Copyright (c) 2017 lugearma. All rights reserved.
//

import UIKit
import LASettingsLauncherMenu

final class ViewController: UIViewController {
  
  let settingsLauncher = LASettingsLauncherMenu()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func showMenu() {
    
    settingsLauncher.showSettings()
  }
}

