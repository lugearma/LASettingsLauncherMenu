//
//  LASettingsLauncherMenuCell.swift
//
//
//  Created by Luis Arias on 7/22/17.
//

import UIKit

@available(iOS 9.0, *)
public final class LASettingsLauncherMenuCell: UICollectionViewCell {
  
  static let identifier = "LASettingsLauncherMenuCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect( x: 0, y: 0, width: 100, height: 100))

    imageView.contentMode = .scaleAspectFill
    imageView.tintColor = .black
    
    let widthConstaraint = imageView.widthAnchor.constraint(equalToConstant: 15)
    let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 15)
    NSLayoutConstraint.activate([widthConstaraint, heightConstraint])
    return imageView
  }()
  
  let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 10
    return stackView
  }()
  
  public override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? .darkGray : .white
      titleLabel.textColor = isHighlighted ? .white : .black
      iconImageView.tintColor = isHighlighted ? .white : .black
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 func configuration(image: UIImage?, title: String) {
    let image = image?.withRenderingMode(.alwaysTemplate)
    iconImageView.image = image
    titleLabel.text = title
  }
  
  fileprivate func setupViews() {
    
    containerStackView.addArrangedSubview(iconImageView)
    containerStackView.addArrangedSubview(titleLabel)
    
    addSubview(containerStackView)
    
    addConstraintsWithFormat(format: "H:|-16-[v0]|", view: containerStackView)
    addConstraintsWithFormat(format: "V:|[v0]|", view: containerStackView)
  }
}
