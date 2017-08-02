//
//  LASettingsLauncherMenu.swift
//  Pods
//
//  Created by Luis Arias on 7/22/17.
//

import UIKit

public protocol LASettingsLauncherMenuDataSource: class {
  
  func dataForMenu() -> [LASettingsLauncherMenuModel]
}

public protocol LASettingsLauncherMenuDelegate: class {
  
  func didHideMenu(_ menu: LASettingsLauncherMenu)
  func settingLauncherMenu(_ menu: LASettingsLauncherMenu, didSelectItemAt indexPath: IndexPath)
}

public final class LASettingsLauncherMenu: NSObject {
  
  fileprivate let blackView = UIView()
  
  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectioView.backgroundColor = .white
    return collectioView
  }()
  
  public weak var dataSource: LASettingsLauncherMenuDataSource?
  public weak var delegate: LASettingsLauncherMenuDelegate?
  
  fileprivate var window: UIWindow {
    
    guard let window = UIApplication.shared.keyWindow else { fatalError() }
    return window
  }
  
  fileprivate var numberOfItemsInDataSource: Int {
    
    guard let data = dataSource?.dataForMenu() else { fatalError("Set valid data source") }
    
    return data.count
  }
  
  fileprivate var height: CGFloat {
    
    let porcentageOfMaxHeight = Int(window.frame.height * 0.7)
    let module = porcentageOfMaxHeight % 50
    let maxHeight = CGFloat(porcentageOfMaxHeight - module)
    
    let heightBasedInNumberOfItems = CGFloat(numberOfItemsInDataSource) * 50
    
    return heightBasedInNumberOfItems < maxHeight ? heightBasedInNumberOfItems : maxHeight
  }
  
  public override init() {
    super.init()
    
    loadCollectionView()
  }
  
  private func loadCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    
    if #available(iOS 9.0, *) {
      
      collectionView.register(LASettingsLauncherMenuCell.self, forCellWithReuseIdentifier: LASettingsLauncherMenuCell.identifier)
    }
      
    else { fatalError("Unavailable for your iOS version. Use 9 or above") }
  }
  
  public func showSettingMenu() {
    
    blackView.frame = window.frame
    blackView.backgroundColor = .black
    blackView.alpha = 0
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
    blackView.addGestureRecognizer(gesture)
    
    window.addSubview(blackView)
    window.addSubview(collectionView)
    
    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: animationWhenShow, completion: nil)
  }
  
  @objc fileprivate func handleDismissWithSelection(completion: @escaping (Bool) -> Void) {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: animationsWhenDismiss, completion: completion)
  }
  
  @objc fileprivate func handleDismiss() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: animationsWhenDismiss) { _ in
      self.delegate?.didHideMenu(self)
      self.blackView.removeFromSuperview()
      self.collectionView.removeFromSuperview()
    }
  }
  
  private func animationWhenShow() {
    let y = window.frame.height - height
    
    self.blackView.alpha = 0.5
    self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }
  
  private func animationsWhenDismiss() -> Void {
    self.blackView.alpha = 0.0
    self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }
}

// MARK: - UICollectionViewDataSource

extension LASettingsLauncherMenu: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let numberOfItems = dataSource?.dataForMenu().count else { fatalError("Set a valid data source") }
    
    return numberOfItems
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if #available(iOS 9.0, *) {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LASettingsLauncherMenuCell.identifier, for: indexPath) as? LASettingsLauncherMenuCell else {
        fatalError("Can't dequeue cell")
      }
      
      guard let data = dataSource?.dataForMenu() else { fatalError("Set a valid data source") }
      
      let dataForCell = data[indexPath.row]
      
      cell.configuration(image: dataForCell.image, title: dataForCell.title)
      return cell
    }
      
    else { fatalError("Unavailable for your iOS version. Use 9 or above") }
  }
}

// MARK: - UICollectionViewDelegate

extension LASettingsLauncherMenu: UICollectionViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
    handleDismissWithSelection() { _ in
      
      self.blackView.removeFromSuperview()
      self.collectionView.removeFromSuperview()
      self.delegate?.settingLauncherMenu(self, didSelectItemAt: indexPath)
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LASettingsLauncherMenu: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.width, height: 50)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return 0
  }
}

