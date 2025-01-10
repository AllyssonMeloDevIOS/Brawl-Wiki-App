//
//  RarityCollectionViewCell.swift
//  Brawl Stars Wiki
//
//  Created by admin on 05/01/25.
//

import UIKit

class RarityCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "RarityCollectionViewCell"
    
    lazy var screen: RarityCollectionViewCellScreen = {
        let view = RarityCollectionViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(screen)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: topAnchor),
            screen.leadingAnchor.constraint(equalTo: leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
