//
//  LASettingsLauncherMenu.swift
//  Pods
//
//  Created by Luis Arias on 7/22/17.
//

import UIKit

private let reuseIdentifier = "Cell"

public final class LASettingsLauncherMenu: NSObject {

  let blackView = UIView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectioView.backgroundColor = .white
    return collectioView
  }()
  
  var window: UIWindow {
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
  
  public func handleDismiss() {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut,
                   animations: {
                    self.blackView.alpha = 0.0
                    self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    },
                   completion: {_ in
                    self.blackView.removeFromSuperview()
                    self.collectionView.removeFromSuperview()
    })
  }
}

extension LASettingsLauncherMenu: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
    if #available(iOS 9.0, *) {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LASettingsLauncherMenuCell.identifier, for: indexPath) as? LASettingsLauncherMenuCell else {
        fatalError("Can't dequeue cell")
      }
      return cell
    } else {
      fatalError()
    }
  }
}

extension LASettingsLauncherMenu: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 50)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

