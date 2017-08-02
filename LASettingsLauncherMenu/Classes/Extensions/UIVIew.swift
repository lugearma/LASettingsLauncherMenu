//
//  UIVIew.swift
//  Pods
//
//  Created by Luis Arias on 7/22/17.
//
//

import Foundation

extension UIView {
  
  public func addConstraintsWithFormat(format: String, view: UIView...) {
    
    var viewDictionary = [String: UIView]()
    
    for (index, view) in view.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    
  }
}
