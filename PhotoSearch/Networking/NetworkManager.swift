//
//  NetworkManager.swift
//  PhotoSearch
//
//  Created by deniss.lobacs on 16/05/2022.
//

import Foundation

struct NetworkManager {
    
  //  var results: [Hit] = []
    
    static func fetchPhoto(for category: String, completion: @escaping (Result<[Hit], Error>) -> Void) {
        
        let url = withCategory(category)
        guard let url = url else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(PhotoData.self, from: data)
                let results = decodedData.hits
                
                completion(.success(results))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
