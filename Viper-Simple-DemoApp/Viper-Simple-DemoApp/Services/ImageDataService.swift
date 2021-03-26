//
//  ImageDataService.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import UIKit


class ImageDataService {
    
    static let shared = { ImageDataService() }()
    
    func convertToUIImage(from data: Data) -> UIImage {
        return UIImage(data: data) ?? UIImage()
    }
}
