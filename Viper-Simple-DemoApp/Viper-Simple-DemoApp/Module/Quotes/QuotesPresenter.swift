//
//  QuotesPresenter.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import Foundation


class QuotesPresenter: ViewToPresenterQuotesProtocol {
    
    // MARK:- Properties
    weak var view: PresenterToViewQuotesProtocol?
    var interactor: PresenterToInteractorQuotesProtocol?
    var router: PresenterToRouterQuotesProtocol?
    
    var quotesStrings: [String]?
    
    // MARK:- Inputs From View
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadQuotes()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadQuotes()
    }
    
    func numberOfRowInSection() -> Int {
        guard let quotesStrings = self.quotesStrings else { return 0 }
        
        return quotesStrings.count
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        guard let quotesStrings = self.quotesStrings else { return nil }
        
        return quotesStrings[indexPath.row]
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveQuotes(at: index)
    }
    
    func deSelectRowAt(index: Int) {
        view?.deselectRow(row: index)
    }
}

// MARK: - Outputs to view
extension QuotesPresenter: InteractorToPresenterQuotesProtocol {
    
    func fetchQuotesSuccess(quotes: [Quote]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.quotesStrings = quotes.compactMap { $0.quote }
        view?.hideHUD()
        view?.onFetchQuotesSucess()
    }
    
    func fetchQuotesFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        view?.onFetchQuotesFailure(error: "Couldn't fetch quotes: \(errorCode)")
    }
    
    func getQuotesSuccess(_ quote: Quote) {
        router?.pushToQuoteDetail(on: view!, with: quote)
    }
    
    func getQuoteFaliure() {
        view?.hideHUD()
        print("Couldn't retrieve quote by index")
    }
}
