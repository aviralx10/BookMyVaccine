//
//  NetworkManager.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import Foundation
import Combine

struct NetworkManager {
    var session = URLSession.shared
    
    func fetch<T: Decodable>(_ type: T.Type = T.self, from url: URL) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: url)
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetch<T: Decodable>(_ type: T.Type = T.self, from url: URL, completion: @escaping (Result<T, Error>)->Void) {
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                let result = Result { try JSONDecoder().decode(T.self, from: data) }
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        .resume()
    }
    
}
