//
//  ViewController.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 02.03.2022.
//

import UIKit

class MainViewController: UIViewController {
  
  let tableView: UITableView = {
    let result = UITableView(frame: .zero, style: .plain)
    result.translatesAutoresizingMaskIntoConstraints = false
    return result
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    self.title = "Main"
    
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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.reloadData()
  }
}

//MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    TypeGCDWork.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = TypeGCDWork.allCases[indexPath.row].rawValue
    return cell
  }
}

//MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currentType = TypeGCDWork.allCases[indexPath.row]

    if let navController = self.navigationController {
      navController.pushViewController(DonwloadViewController(type: currentType),
                                       animated: true)
    } else {
      print("error")
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
