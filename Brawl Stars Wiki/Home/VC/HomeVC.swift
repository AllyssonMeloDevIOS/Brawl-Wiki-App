//
//  ViewController.swift
//  Brawl Stars Wiki
//
//  Created by admin on 03/03/24.
//

import UIKit

class HomeVC: UIViewController {

    var homeScreen: HomeScreen?
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        homeScreen = HomeScreen()
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreen?.delegate(delegate: self)
//        viewModel.fetchRequest()
    }
}

extension HomeVC: HomeScreenProtocol {
    func tappedBrawlerButton() {
        let vc: BrawlerVC = BrawlerVC()
        self.navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
    
    func tappedItemButton() {
        let vc: ItemVC = ItemVC()
        self.navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
}
