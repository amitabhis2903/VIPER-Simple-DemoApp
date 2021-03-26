//
//  QuotesInteractor.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import Foundation


class QuotesInteractor: PresenterToInteractorQuotesProtocol {
        
    // MARK: Properties
    weak var presenter: InteractorToPresenterQuotesProtocol?
    var quotes: [Quote]?
    
    func loadQuotes() {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        QuotesService.shared.getQuotes(count: 6) { [weak self] (code, quotes) in
            guard let strongSelf = self else { return }
            strongSelf.quotes = quotes
            strongSelf.presenter?.fetchQuotesSuccess(quotes: quotes)
            
        } failure: { [weak self] (code) in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.fetchQuotesFailure(errorCode: code)
        }
    }
    
    func retrieveQuotes(at index: Int) {
        guard let quotes = self.quotes, quotes.indices.contains(index) else {
            self.presenter?.getQuoteFaliure()
            return
        }
        
        self.presenter?.getQuotesSuccess(self.quotes![index])
    }
}
