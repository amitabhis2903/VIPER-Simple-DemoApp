//
//  Quote.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import ObjectMapper

struct Quote: Mappable {
    
    var quote: String?
    var character: String?
    var image: String?
    var characterDirection: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        quote              <- map["quote"]
        character          <- map["character"]
        image              <- map["image"]
        characterDirection <- map["characterDirection"]
    }
}
