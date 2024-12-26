//
//  BrawlerScreen.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class BrawlerScreen: UIView {

    lazy var labelBralwer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Brawlers"
        
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.register(BrawlerTableViewCell.self, forCellReuseIdentifier: BrawlerTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        return tableView
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
        addSubview(labelBralwer)
        addSubview(tableView)
        
    }
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            labelBralwer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            labelBralwer.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: labelBralwer.bottomAnchor,constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
        ])
    }
}
