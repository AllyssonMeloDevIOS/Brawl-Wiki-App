//
//  BrawlerTableViewCell.swift
//  Brawl Stars Wiki
//
//  Created by admin on 04/03/24.
//

import UIKit
import SDWebImage

class BrawlerTableViewCell: UITableViewCell {

    static let identifier: String = String(String(describing: BrawlerTableViewCell.self))
    
    lazy var screen: BrawlerTableViewCellScreen = {
        let view = BrawlerTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addviews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addviews() {
        contentView.addSubview(screen)
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setupBrawlerCell(data: List) {

        if let imageURLString = data.imageUrl2, let url = URL(string: imageURLString) {
                screen.iconBrawl.sd_setImage(with: url)
            }
            

            screen.nameBrawler.text = data.name ?? "Sem Nome"
            

            if let rarity = data.rarity {

                if let borderColor = rarity.color, let color = UIColor(hex: borderColor.rawValue) {
                    screen.iconBrawl.layer.borderColor = color.cgColor
                } else {
                    screen.iconBrawl.layer.borderColor = UIColor.clear.cgColor
                }
                

                if let textColor = rarity.color, let color = UIColor(hex: textColor.rawValue) {
                    screen.nameBrawler.textColor = color
                } else {
                    screen.nameBrawler.textColor = UIColor.black
                }
            }
            

            screen.iconBrawl.layer.borderWidth = 3.0
    }
                                          
}

extension UIColor {

    convenience init?(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 6 {
            var rgb: UInt64 = 0
            Scanner(string: hexSanitized).scanHexInt64(&rgb)
            
            self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        } else {
            return nil
        }
    }
}
