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
  
  let image: UIImageView = {
    let result = UIImageView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.image = UIImage(systemName: "sun.max")
//    result.image?.resizingMode = .
//    result.clipsToBounds = true
//    result.contentMode = .scaleAspectFit
    return result
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(image)
//    self.image.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      image.topAnchor.constraint(equalTo: self.topAnchor),
      image.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//      activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//      activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//      image.heightAnchor.constraint(equalToConstant: 150)
//      self.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
