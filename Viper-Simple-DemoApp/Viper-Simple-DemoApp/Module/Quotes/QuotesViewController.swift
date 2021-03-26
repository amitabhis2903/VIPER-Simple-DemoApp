//
//  QuotesViewController.swift
//  Viper-Simple-DemoApp
//
//  Created by MacBook05 on 25/03/21.
//

import UIKit
import PKHUD


class QuotesViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterQuotesProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
}


extension QuotesViewController: PresenterToViewQuotesProtocol {
    
    func onFetchQuotesSucess() {
        print("View receives the response from Presenter and updates itself.")
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func onFetchQuotesFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func deselectRow(row: Int) {
        tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
}

// MARK: - UITableView Delegate & Data Source
extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.textLabelText(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
        presenter?.deSelectRowAt(index: indexPath.row)
    }
}


// MARK: - UI Setup
extension QuotesViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.navigationItem.title = "Quotes"
    }
}
