//
//  APIManger.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import Foundation


class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://thesimpsonsquoteapi.glitch.me/"
    }()
}
