//
//  DownloadViewController.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 06.03.2022.
//


import UIKit

class DonwloadViewController: UIViewController {
  
  let imageUrls = Images()
  var images = [UIImage]()
  let typeGCDController: TypeGCDWork
  
  let tableView: UITableView = {
    let result = UITableView(frame: .zero, style: .plain)
    result.translatesAutoresizingMaskIntoConstraints = false
//    result.backgroundColor = .secondarySystemBackground
    return result
  }()
  
  init(type: TypeGCDWork) {
    typeGCDController = type
    super.init(nibName: nil, bundle: nil)
    
    title = typeGCDController.rawValue
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                     constant: 16),
      tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
    ])
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(FlagCell.self, forCellReuseIdentifier: "imageCell")
    tableView.reloadData()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
  }
  
  @objc private func handleAdd() {
    typeGCDController.handleAdd(self)
  }
}

//MARK: UITableViewDataSource

extension DonwloadViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if images.count == 0 {
      return imageUrls.imagesUrls.count
    } else {
      return images.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell",
                                             for: indexPath)
    if let cell = cell as? FlagCell, !images.isEmpty {
        cell.image.image = images[indexPath.row]
      }
    return cell
  }
}

//MARK: UITableViewDelegate

extension DonwloadViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

