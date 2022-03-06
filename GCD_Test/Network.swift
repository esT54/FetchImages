//
//  Network.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 02.03.2022.
//

import UIKit

class Network {
  private init() {}
  static let shared = Network()
  
  lazy var urlSession = URLSession(configuration: .default)
  
  func getImage(url: String, complition: @escaping (UIImage) -> Void) {
    
    if let url = URL(string: url) {
      let dataTask = urlSession.dataTask(with: url) { data, _, error in
        guard error == nil else {print(error!.localizedDescription); return }
        if let data = data {
          let result = UIImage(data: data)
          complition(result!)
        }
      }
        dataTask.resume()
    }
  }
  
  func fetchImage(url: URL, index: Int?, complitionHandler: @escaping (Result<(UIImage, Int?), Error>) -> Void) {
    let task = urlSession.dataTask(with: url) { data, responce, error in
      if let error = error {
        complitionHandler(.failure(error))
      }
      if let httpResponce = responce as? HTTPURLResponse {
        if httpResponce.statusCode == 200, let data = data {
          if let image = UIImage(data: data) {
            complitionHandler(.success((image, index)))
          } else {
            complitionHandler(.failure(NetworkErrors.invalidImageData))
          }
        } else {
          complitionHandler(.failure(NetworkErrors.not200ServerResponce(status: httpResponce.statusCode)))
        }
      } else {
        complitionHandler(.failure(NetworkErrors.invalidServerResponce))
      }
    }
    task.resume()
  }
  
}
