//
//  HomeViewModel.swift
//  Brawl Stars Wiki
//
//  Created by admin on 09/03/24.
//

import Foundation

//protocol HomeViewModelProtocol: AnyObject {
//    func success()
//    func error(message: String)
//}
//
//class HomeViewModel {
//    
//    private var service: HomeService = HomeService()
//    private var brawlerList: [List] = []
//    
//    private weak var delegate: HomeViewModelProtocol?
//    
//    public func delegate(delegate: HomeViewModelProtocol?) {
//        self.delegate = delegate
//    }
//    
//    
//    public func fetchRequest() {
//        service.getBrawlerList { [weak self] result in
//            guard let self else { return }
//            switch result {
//
//            case.success(let result):
//                self.brawlerList = result.list ?? []
//                
//                delegate?.success()
//            case .failure(let failure):
//                delegate?.error(message: failure.errorDescription ?? "")
//            }
//        }
//    }

class HomeViewModel {
    
    private var service: HomeServiceProtocol
        private var brawlerList: [List] = []
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    func fetchRequest() {
        service.getBrawlerList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.brawlerList = result.list ?? []
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.errorDescription ?? "Erro desconhecido")
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

