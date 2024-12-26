//
//  HomeScreen.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

protocol HomeScreenProtocol : AnyObject {
    func tappedBrawlerButton()
    func tappedItemButton()
}

class HomeScreen: UIView {
    
    weak var delegate: HomeScreenProtocol?
    
    func delegate(delegate: HomeScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var brawlerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Brawler", for: .normal)
        button.addTarget(self, action: #selector(tappedBrawlerButton), for: .touchUpInside)
        
        return button
    }()
    
        @objc func tappedBrawlerButton(_ sender: UIButton) {
            delegate?.tappedBrawlerButton()
//            print(#function)
    
        }
    
    lazy var itemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Item", for: .normal)
        button.addTarget(self, action: #selector(tappedItemButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tappedItemButton() {
            delegate?.tappedItemButton()
//            print(#function)
        }
    
    lazy var logoBS: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Brawl_Stars")
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addviews()
        configConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addviews() {
        addSubview(logoBS)
        addSubview(brawlerButton)
        addSubview(itemButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            logoBS.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            logoBS.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoBS.widthAnchor.constraint(equalToConstant: 80),
            logoBS.heightAnchor.constraint(equalToConstant: 70),
            
            brawlerButton.topAnchor.constraint(equalTo: logoBS.bottomAnchor, constant: 10),
            brawlerButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30),
            brawlerButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            
            itemButton.topAnchor.constraint(equalTo: brawlerButton.bottomAnchor, constant: 20),
            itemButton.leadingAnchor.constraint(equalTo: brawlerButton.leadingAnchor),
            itemButton.trailingAnchor.constraint(equalTo: brawlerButton.trailingAnchor),
            
        ])
    }
    
}
