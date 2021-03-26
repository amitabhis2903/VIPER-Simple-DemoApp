//
//  QuoteDetailInteractor.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 26/03/21.
//

import Foundation


class QuoteDetailInteractor: PresenterToInteractorQuoteDetailProtocol {    
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterQuoteDetailProtocol?
    var quote: Quote?
    
    func getImageDataFromURL() {
        print("Interactor receives the request from Presenter to get image data from the server.")
        guard let quote = quote,
              let urlString = quote.image else { return }
        KingFisherService.shared.loadImageFrom(urlString: urlString) { (data) in
            self.presenter?.getImageFromURLSuccess(quote: quote, data: data)
            
        } failure: { (error) in
            self.presenter?.getImageFromURLFailure(quote: quote)
        }

    }
}
