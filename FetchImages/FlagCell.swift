//
//  FlagCell.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 02.03.2022.
//

import UIKit

class FlagCell: UITableViewCell {
  let activityIndicator: UIActivityIndicatorView = {
    let result = UIActivityIndicatorView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.style = .medium
    return result
  }()
  
  let flagImage: UIImageView = {
    let result = UIImageView()
    result.translatesAutoresizingMaskIntoConstraints = false
    return result
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(flagImage)
    self.flagImage.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      flagImage.topAnchor.constraint(equalTo: self.topAnchor),
      flagImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      flagImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      flagImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
