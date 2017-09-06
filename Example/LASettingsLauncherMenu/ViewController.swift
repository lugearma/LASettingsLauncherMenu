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
    settingsLauncher.animationOptions = .curveEaseInOut
  }
  
  @IBAction func showMenu() {
    
    settingsLauncher.showSettingMenu()
  }
}

// MARK: - LASettingsLauncherMenuDelegate

extension ViewController: LASettingsLauncherMenuDelegate {
  
  func didHideMenu(_ menu: LASettingsLauncherMenu) {
    print(#function)
  }
  
  func settingLauncherMenu(_ menu: LASettingsLauncherMenu, didSelectItemAt indexPath: IndexPath) {
    presentNewViewController()
  }
  
  private func presentNewViewController() {
    let newVC = SecondViewController()
    newVC.title = "Title"
    navigationController?.pushViewController(newVC, animated: true)
  }
}

// MARK: - LASettingsLauncherMenuDataSource

extension ViewController: LASettingsLauncherMenuDataSource {
  
  func dataForMenu() -> [LASettingsLauncherMenuModel] {
    
    return [
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings")),
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "settings"))
    ]
  }
}
