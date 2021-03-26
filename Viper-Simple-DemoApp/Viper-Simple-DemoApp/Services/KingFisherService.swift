//
//  KingFisherService.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import Foundation
import Kingfisher


class KingFisherService {
    
    static let shared = { KingFisherService() }()
    
    func loadImageFrom(urlString: String, success: @escaping (Data) -> (), failure: @escaping (KingfisherError) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) { [weak self] (result) in
            guard let _ = self else { return }
            
            switch result {
            case .success(let value):
                print("Data \(value.originalData)")
                success(value.originalData)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                failure(error)
            }
        }
    }
}
