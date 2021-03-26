//
//  Quotes.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewQuotesProtocol: class {
    func onFetchQuotesSucess()
    func onFetchQuotesFailure(error: String)
    
    func showHUD()
    func hideHUD()
    
    func deselectRow(row: Int)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterQuotesProtocol: class {
    
    var view: PresenterToViewQuotesProtocol? { get set }
    var interactor: PresenterToInteractorQuotesProtocol? { get set }
    var router: PresenterToRouterQuotesProtocol? { get set }
    
    var quotesStrings: [String]? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func deSelectRowAt(index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorQuotesProtocol: class {
    var presenter: InteractorToPresenterQuotesProtocol? { get set }
    
    func loadQuotes()
    func retrieveQuotes(at index: Int)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterQuotesProtocol: class {
    func fetchQuotesSuccess(quotes: [Quote])
    func fetchQuotesFailure(errorCode: Int)
    
    func getQuotesSuccess(_ quote: Quote)
    func getQuoteFaliure()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterQuotesProtocol: class {
    
    static func createModule() -> UINavigationController
    
    func pushToQuoteDetail(on view: PresenterToViewQuotesProtocol, with quote: Quote)
}

