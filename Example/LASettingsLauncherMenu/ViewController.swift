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
    
    configureMenu()
  }
  
  func configureMenu() {
    settingsLauncher.delegate = self
    settingsLauncher.dataSource = self
  }
  
  @IBAction func showMenu() {
    
    settingsLauncher.showSettingMenu()
  }
}

extension ViewController: LASettingsLauncherMenuDelegate {
  
  func didHideMenu(_ menu: LASettingsLauncherMenu) {
    print(#function)
  }
  
  func settingLauncherMenu(_ menu: LASettingsLauncherMenu, didSelectItemAt indexPath: IndexPath) {
    let newVC = SecondViewController()
    newVC.title = "Title"
    navigationController?.pushViewController(newVC, animated: true)
  }
}

extension ViewController: LASettingsLauncherMenuDataSource {
  
  func dataForMenu() -> [LASettingsLauncherMenuModel] {
    
    let settings = LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings"))
    let settingsTwo = LASettingsLauncherMenuModel(title: "SettingsTwo", image: UIImage(named: "settings"))
    let settingsThree = LASettingsLauncherMenuModel(title: "SettingsThree", image: UIImage(named: "settings"))
    return [settings, settingsTwo, settingsThree]
  }
}
