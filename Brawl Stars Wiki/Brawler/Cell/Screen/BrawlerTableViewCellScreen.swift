//
//  BrawlerTableViewCellScreen.swift
//  Brawl Stars Wiki
//
//  Created by admin on 04/03/24.
//

import UIKit

class BrawlerTableViewCellScreen: UIView {
    
    lazy var nameBrawler: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
                
        return label
    }()
    
    lazy var iconBrawl: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
        addSubview(nameBrawler)
        addSubview(iconBrawl)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            iconBrawl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            iconBrawl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconBrawl.heightAnchor.constraint(equalToConstant: 50),
            iconBrawl.widthAnchor.constraint(equalToConstant: 50),
            
            nameBrawler.leadingAnchor.constraint(equalTo: iconBrawl.trailingAnchor, constant: 10),
            nameBrawler.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }

}
