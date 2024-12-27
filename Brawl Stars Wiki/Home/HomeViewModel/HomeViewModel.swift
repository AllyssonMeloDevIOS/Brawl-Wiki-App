//
//  HomeViewModel.swift
//  Brawl Stars Wiki
//
//  Created by admin on 09/03/24.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class HomeViewModel {

    private let service: HomeServiceProtocol
    private weak var delegate: HomeViewModelProtocol?
    private var brawlerList: [List] = []

    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }

    public func setDelegate(_ delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }

    public func fetchRequest() {
        service.getBrawlerList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.brawlerList = result.list ?? []
                self.delegate?.success()
            case .failure(let failure):
                self.delegate?.error(message: failure.errorDescription ?? "")
            }
       }
    }

    public var numberOfRowsInSection: Int {
        return brawlerList.count
    }

    func loadCurrentBrawler(indexPath: IndexPath) -> List? {
        guard indexPath.row < brawlerList.count else { return nil }
        return brawlerList[indexPath.row]
    }
}
