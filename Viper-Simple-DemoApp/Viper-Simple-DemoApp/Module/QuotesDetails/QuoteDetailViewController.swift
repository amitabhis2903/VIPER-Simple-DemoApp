//
//  QuoteDetailViewController.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 26/03/21.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterQuoteDetailProtocol?
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
}

extension QuoteDetailViewController: PresenterToViewQuoteDetailProtocol {
    
    func onGetImageFromURLSuccess(_ quote: String, character: String, image: UIImage) {
        print("View receives the response from Presenter and updates itself.")
        
        quoteLabel.text = quote
        characterImageView.image = image
        navigationItem.title = character
    }
    
    func onGetImageFromURLFailure(_ quote: String, character: String) {
        print("View receives the response from Presenter and updates itself.")
        
        quoteLabel.text = quote
        navigationItem.title = character
    }
}

// MARK: - UI Setup
extension QuoteDetailViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(characterImageView)
        self.view.addSubview(quoteLabel)
        
        let widthHeightConstant = self.view.frame.width * 0.8
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.widthAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20)
            .isActive = true
        quoteLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor)
            .isActive = true
        quoteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
    }
    
}
