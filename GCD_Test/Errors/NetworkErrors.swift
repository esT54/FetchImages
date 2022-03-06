//
//  NetworkErrors.swift
//  GCD_Test
//
//  Created by Semen Smirnyagin on 05.03.2022.
//

enum NetworkErrors: Error {
  case not200ServerResponce(status: Int)
  case invalidImageData
  case invalidServerResponce
  
  var discription: String {
    switch self {
    case .not200ServerResponce(let status):
      return "Invalid server responce: \(status)"
    case .invalidImageData:
     return "Invalid image data"
    case .invalidServerResponce:
      return "Invalid server responce"
    }
  }
}
