//
//  TypesGCDWork.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 02.03.2022.
//

import UIKit


enum TypeGCDWork: String, CaseIterable {
  case simpleDownloadImages = "Simple download images"
  case groupDownloadImages = "Group download images"
  case savePositionGroupDownloadImages = "Save position group download images"
  
  var handleAdd: (_ controller: UIViewController)->() {
    switch self {
    case .simpleDownloadImages:
      return { (controller: UIViewController) in
        if let controller = controller as? DonwloadViewController {
          controller.images = []
          controller.imageUrls.imagesUrls.forEach { imageUrl in
            DispatchQueue.global().async {
              Network.shared.getImage(url: imageUrl) { image in
                controller.images.append(image)
                DispatchQueue.main.async {
                  controller.tableView.reloadData()
                }
              }
            }
          }
        }
      }
      
    case .groupDownloadImages:
      return { (controller: UIViewController) in
        if let controller = controller as? DonwloadViewController {
          controller.images = []
          let group = DispatchGroup()
          
          controller.imageUrls.imagesUrls.forEach { imageUrl in
            group.enter()
            DispatchQueue.global().async {
              Network.shared.getImage(url: imageUrl) { image in
                controller.images.append(image)
                group.leave()
              }
            }
          }
          group.notify(queue: DispatchQueue.main) {
            var indexPaths = [IndexPath]()
            for index in 0..<controller.images.count {
              indexPaths.append(IndexPath(row: index, section: 0))
            }
            controller.tableView.reloadRows(at: indexPaths, with: .left)
          }
        }
      }
      
    case .savePositionGroupDownloadImages:
      return {(controller: UIViewController) in
        if let controller = controller as? DonwloadViewController {
          controller.images = [UIImage].init(repeating: UIImage(systemName: "sun.max")!, count: controller.imageUrls.imagesUrls.count)
          let group = DispatchGroup()
          let queue = DispatchQueue(label: "ru.Myqueue",
                                    qos: .default,
                                    attributes: .concurrent)
          for (index, value) in controller.imageUrls.imagesUrls.enumerated() {
            
            //    }
            //    self.imageUrls.imagesUrls.forEach { value in
            group.enter()
            print("in \(index)")
            //        print(value)
            if let url = URL(string: value) {
              Network.shared.fetchImage(url: url, index: index) { result in
                switch result {
                case .success((let image, let index)):
                  queue.async(flags: .barrier) {
                    controller.images[index!] = image
                    print("записал \(controller.images.count) \(index)")
                  }
                case .failure(let error):
                  if let error = error as? NetworkErrors {
                    print(error.discription)
                  }
                }
                group.leave()
                print("out")
              }
            }
          }
          group.notify(queue: queue) {
            print("notify")
            DispatchQueue.main.async {
              controller.tableView.reloadData()
            }
          }
        }
      }
    }
  }
}
