//
//  Brawl_Stars_WikiTests.swift
//  Brawl Stars WikiTests
//
//  Created by admin on 03/03/24.
//

import XCTest
@testable import Brawl_Stars_Wiki

final class Brawl_Stars_WikiTests: XCTestCase {
    
    private let serviceMock = HomeServiceMock()
    private let delegateSpy = HomeViewModelDelegateSpy()
    
    lazy var sut: HomeViewModel = {
        let viewModel = HomeViewModel(service: serviceMock)
        viewModel.setDelegate(delegateSpy)
        return viewModel
    }()
    
    func testFetchRequest_WhenDataAvailable_ShouldCallSuccess() {
        // Given
        let mockData: [List] = [
            List(
                id: 1,
                avatarID: 101,
                name: "Brawler1",
                hash: "hash1",
                path: nil,
                fankit: nil,
                released: true,
                version: 1,
                link: "https://example.com/brawler1",
                imageURL: "https://example.com/image1.png",
                imageUrl2: nil,
                imageUrl3: nil,
                listClass: Class(id: 1, name: .tank),
                rarity: Rarity(id: 1, name: .common, color: .fff11E),
                description: "Brawler1 Description",
                descriptionHTML: "<p>Brawler1 Description</p>",
                starPowers: nil,
                gadgets: nil
            ),
            List(
                id: 2,
                avatarID: 102,
                name: "Brawler2",
                hash: "hash2",
                path: nil,
                fankit: nil,
                released: false,
                version: 1,
                link: "https://example.com/brawler2",
                imageURL: "https://example.com/image2.png",
                imageUrl2: nil,
                imageUrl3: nil,
                listClass: Class(id: 2, name: .damageDealer),
                rarity: Rarity(id: 2, name: .rare, color: .fe5E72),
                description: "Brawler2 Description",
                descriptionHTML: "<p>Brawler2 Description</p>",
                starPowers: nil,
                gadgets: nil
            )
        ]
        serviceMock.expectedResult = .success(BrawlWiki(list: mockData))
        
        // When
        sut.fetchRequest()
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSection, mockData.count)
        XCTAssertEqual(delegateSpy.successCalledCount, 1)
        XCTAssertEqual(delegateSpy.errorMessages.count, 0)
    }
    
    func testFetchRequest_WhenNoData_ShouldCallSuccessWithEmptyList() {
        // Given
        serviceMock.expectedResult = .success(BrawlWiki(list: []))
        
        // When
        sut.fetchRequest()
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSection, 0)
        XCTAssertEqual(delegateSpy.successCalledCount, 1)
        XCTAssertEqual(delegateSpy.errorMessages.count, 0)
    }
    
    func testFetchRequest_WhenErrorOccurs_ShouldCallError() {
        // Given
        serviceMock.expectedResult = .failure(NetworkError.invalidResponse)
        
        // When
        sut.fetchRequest()
        
        // Then
        XCTAssertEqual(sut.numberOfRowsInSection, 0)
        XCTAssertEqual(delegateSpy.successCalledCount, 0)
        XCTAssertEqual(delegateSpy.errorMessages, ["Resposta inválida da API"])
    }
}

// Mock do serviço
fileprivate class HomeServiceMock: HomeServiceProtocol {
    var expectedResult: Result<BrawlWiki, NetworkError> = .success(BrawlWiki(list: []))
    
    func getBrawlerList(completion: @escaping (Result<BrawlWiki, NetworkError>) -> Void) {
        completion(expectedResult)
    }
}

// Spy para o protocolo
fileprivate class HomeViewModelDelegateSpy: HomeViewModelProtocol {
    var successCalledCount = 0
    var errorMessages: [String] = []
    
    func success() {
        successCalledCount += 1
    }
    
    func error(message: String) {
        errorMessages.append(message)
    }
}
