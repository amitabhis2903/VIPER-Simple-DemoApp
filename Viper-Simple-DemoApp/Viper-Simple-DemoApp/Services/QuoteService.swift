//
//  QuoteService.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import ObjectMapper

class QuotesService {
    
    static let shared = { QuotesService() }()
    
    func getQuotes(count: Int, success: @escaping (Int, [Quote]) -> (), failure: @escaping (Int) -> ()) {
        
        let urlString = self.configureApiCall(EndPoints.Quotes, "count", "\(count)")
        
        APIClient.shared.getArray(urlString: urlString) { (code, arrayOfQuote) in
            success(code, arrayOfQuote)
        } failure: { (code) in
            failure(code)
        }

    }
    
    func configureApiCall(_ baseUrl: String, _ parameter: String, _ value: String) -> String {
        return baseUrl + "?" + parameter + "=" + value
    }
}
