//
//  BrawlerVC.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class BrawlerVC: UIViewController {

    private var brawlerScreen: BrawlerScreen?
    private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
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
        viewModel.setDelegate(self)
        brawlerScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        viewModel.fetchRequest()
    }
}

extension BrawlerVC: HomeViewModelProtocol {
    func success() {
        DispatchQueue.main.async {
            self.brawlerScreen?.tableView.reloadData()
        }
    }

    func error(message: String) {
        let alertController = UIAlertController(
            title: "Ops, tivemos um problema",
            message: message,
            preferredStyle: .alert
        )
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
