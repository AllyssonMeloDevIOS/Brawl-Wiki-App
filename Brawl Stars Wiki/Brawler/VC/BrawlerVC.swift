//
//  BrawlerVC.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class BrawlerVC: UIViewController {

    var brawlerScreen: BrawlerScreen?
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel(service: HomeService())) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        brawlerScreen = BrawlerScreen()
        view = brawlerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brawlerScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        setupBindings()
        viewModel.fetchRequest()
    }
    
    private func setupBindings() {
            viewModel.onSuccess = { [weak self] in
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }

            viewModel.onError = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showError(message: errorMessage)
                }
            }
        }
    
    private func reloadData() {
        brawlerScreen?.tableView.reloadData()
    }

    private func showError(message: String) {
            let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}

extension BrawlerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrawlerTableViewCell.identifier, for: indexPath) as? BrawlerTableViewCell
        guard let brawler = viewModel.loadCurrentBrawler(indexPath: indexPath) else {
                return UITableViewCell()
            }
            
            cell?.setupBrawlerCell(data: brawler)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


