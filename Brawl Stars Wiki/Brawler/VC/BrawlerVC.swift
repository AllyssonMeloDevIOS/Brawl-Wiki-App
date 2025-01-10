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
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        brawlerScreen?.configCollectionViewProtocols(delegate: self, dataSource: self)
        viewModel.fetchRequest()
        configNavigation()
        configSearchButton()
        searchController.delegate = self
    }
    
    func configSearchButton() {
        if !searchController.isActive {
                // Se o searchController não está ativo (ou seja, a pesquisa não está visível),
                // exibe o botão de lupa na barra de navegação.
                let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
                navigationItem.rightBarButtonItem = searchButton
            }
    }
    
    @objc func didTapSearchButton() {
        searchController.isActive = true
        navigationItem.rightBarButtonItem = nil // Remove o botão de lupa quando o search é ativado
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let height = searchController.searchBar.superview?.frame.height {
            brawlerScreen?.tableView.setContentOffset(CGPoint(x: 0, y: -height), animated: false)
        }
    }
    
    func configNavigation() {
        self.title = "Brawlers"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25, weight: .medium)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        searchController.searchBar.placeholder = "Pesquise pelo nome"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}
extension BrawlerVC: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationItem.rightBarButtonItem = nil // Remove o botão de lupa quando a pesquisa for ativada
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        configSearchButton() // Adiciona o botão de lupa novamente quando a pesquisa for desativada
    }
}

extension BrawlerVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            brawlerScreen?.tableView.reloadData()
            return
        }
        brawlerScreen?.tableView.reloadData()
    }
}

extension BrawlerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RarityCollectionViewCell.identifier, for: indexPath) as? RarityCollectionViewCell
        cell?.screen.filterRarityLabel.text = "Rarity \(indexPath.item)"
        cell?.screen.filterRarityLabel.backgroundColor = .systemBlue
        cell?.screen.filterRarityLabel.textColor = .white
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Célula \(indexPath.item) selecionada")
    }
    
}

// MARK: - HomeViewModelProtocol
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

// MARK: - UITableViewDelegate & UITableViewDataSource
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
        return 70
    }
}

