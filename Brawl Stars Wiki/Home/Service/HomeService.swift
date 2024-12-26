//
//  HomeService.swift
//  Brawl Stars Wiki
//
//  Created by admin on 09/03/24.
//

import Foundation



class HomeService {
    
    func getBrawlerList(completion: @escaping(Result<BrawlWiki,NetworkError>) -> Void) {
        
        let urlString: String = "https://api.brawlify.com/v1/brawlers"
        
        guard let url: URL = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL(url: urlString)))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {  data, response, error in
            
            DispatchQueue.main.async {
                if let error {
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
        }
        task.resume()
    }
}
