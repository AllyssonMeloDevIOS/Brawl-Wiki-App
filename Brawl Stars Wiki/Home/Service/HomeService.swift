//
//  HomeService.swift
//  Brawl Stars Wiki
//
//  Created by admin on 09/03/24.
//

import Foundation

// MARK: - Protocolo criado para a o serviço
protocol HomeServiceProtocol {
    func getBrawlerList(completion: @escaping (Result<BrawlWiki, NetworkError>) -> Void)
}

// MARK: - Protocolo para abstração do URLSession
protocol NetworkSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

class HomeService: HomeServiceProtocol {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getBrawlerList(completion: @escaping(Result<BrawlWiki,NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.brawlify.com/v1/brawlers") else {
            completion(.failure(.invalidURL(url: "https://api.brawlify.com/v1/brawlers")))
            return
        }
        
        
        session.dataTask(with: url) {  data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                print("Status Code: \(response.statusCode)")
                
                guard 200...299 ~= response.statusCode else {
                    print("Invalid Response: \(response)")
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Response Data: \(jsonString)") // Exibe o JSON no console
//                }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(BrawlWiki.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
