//
//  BrawlerScreen.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class BrawlerScreen: UIView {
    
    lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.clipsToBounds = true
            tableView.layer.cornerRadius = 8
            tableView.layer.borderWidth = 2
            tableView.layer.borderColor = UIColor.black.cgColor
            tableView.register(BrawlerTableViewCell.self, forCellReuseIdentifier: BrawlerTableViewCell.identifier)
            tableView.separatorStyle = .singleLine
            tableView.backgroundColor = .systemBackground
            return tableView
        }()
        
        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 80, height: 34)
            layout.minimumLineSpacing = 10
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .clear
            collectionView.register(RarityCollectionViewCell.self, forCellWithReuseIdentifier: RarityCollectionViewCell.identifier)
            return collectionView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            addviews()
            configConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func addviews() {
            addSubview(tableView)
            addSubview(collectionView)
        }
        
        public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
            tableView.delegate = delegate
            tableView.dataSource = dataSource
        }
        
        public func configCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
            collectionView.delegate = delegate
            collectionView.dataSource = dataSource
        }
        
        private func configConstraints() {
            NSLayoutConstraint.activate([
                // CollectionView
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 34),
                
                // TableView
                tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            ])
        }
}
