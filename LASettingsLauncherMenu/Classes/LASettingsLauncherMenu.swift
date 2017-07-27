//
//  LASettingsLauncherMenu.swift
//  Pods
//
//  Created by Luis Arias on 7/22/17.
//

import UIKit

private let reuseIdentifier = "Cell"

public protocol LASettingsLauncherMenuDataSource: class {
  
  func menuModel() -> [LASettingsLauncherMenuModel]
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
  
  public override init() {
    super.init()
    
    loadCollectionView()
  }
  
  private func loadCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    if #available(iOS 9.0, *) {
      collectionView.register(LASettingsLauncherMenuCell.self, forCellWithReuseIdentifier: LASettingsLauncherMenuCell.identifier)
    } else {
      fatalError()
    }
  }
  
  public func showSettings() {
    
    blackView.frame = window.frame
    blackView.backgroundColor = .black
    blackView.alpha = 0
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
    blackView.addGestureRecognizer(gesture)
    
    window.addSubview(blackView)
    window.addSubview(collectionView)
    
    let height: CGFloat = 200
    let y = window.frame.height - height
    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
    
   UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.blackView.alpha = 0.5
      self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }, completion: nil)
  }
  
  public func handleDismiss(completion: @escaping (Bool) -> Void) {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: animationsWhenDismiss, completion: completion)
  }
  
  private func animationsWhenDismiss() -> Void {
    self.blackView.alpha = 0.0
    self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
  }
}

// MARK: - UICollectionViewDataSource

extension LASettingsLauncherMenu: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let numberOfItems = dataSource?.menuModel().count else {
      fatalError()
    }
    
    return numberOfItems
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
    if #available(iOS 9.0, *) {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LASettingsLauncherMenuCell.identifier, for: indexPath) as? LASettingsLauncherMenuCell else {
        fatalError("Can't dequeue cell")
      }
      
      guard let data = dataSource?.menuModel() else {
        fatalError("There's no data source")
      }
      
      let dataForCell = data[indexPath.row]
      
      cell.configuration(image: dataForCell.image, title: dataForCell.title)
      return cell
    }
      
    else {
      fatalError()
    }
  }
}

// MARK: - UICollectionViewDelegate

extension LASettingsLauncherMenu: UICollectionViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    handleDismiss() { _ in
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

