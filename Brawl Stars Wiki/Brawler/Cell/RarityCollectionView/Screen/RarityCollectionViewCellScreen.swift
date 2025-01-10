//
//  RarityCollectionViewCellScreen.swift
//  Brawl Stars Wiki
//
//  Created by admin on 05/01/25.
//

import UIKit

class RarityCollectionViewCellScreen: UIView {
    
    lazy var filterRarityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addviews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addviews() {
        addSubview(filterRarityLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            filterRarityLabel.topAnchor.constraint(equalTo: topAnchor),
            filterRarityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterRarityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterRarityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
