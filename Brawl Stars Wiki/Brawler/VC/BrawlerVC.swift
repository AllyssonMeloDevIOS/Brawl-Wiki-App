//
//  BrawlerVC.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class BrawlerVC: UIViewController {

    var brawlerScreen: BrawlerScreen?
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        brawlerScreen = BrawlerScreen()
        view = brawlerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fetchRequest()
        viewModel.delegate(delegate: self)
        brawlerScreen?.configTableViewProtocols(delegate: self, dataSource: self)

    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchRequest()
        print("viewWillAppear")
    }
    
    
    
}

extension BrawlerVC: HomeViewModelProtocol {
    func success() {
//        self.brawlerScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        DispatchQueue.main.async {
            self.brawlerScreen?.tableView.reloadData()

        }
    }
    
    func error(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, tivemos um problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}

extension BrawlerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrawlerTableViewCell.identifier, for: indexPath) as? BrawlerTableViewCell
        cell?.setupBrawlerCell(data: viewModel.loadCurrentBrawler(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


