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

    static var encoder: JSONEncoder = {
        let decoder = JSONEncoder()
        decoder.dateEncodingStrategy = .iso8601
        return decoder
    }()

    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func create<T: Codable>(_ value: T, on url: URL) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? Self.encoder.encode(value)
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        if let data = request.httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(
                with: data, options: []
            ) {
                if let data = try? JSONSerialization.data(
                    withJSONObject: jsonObject,
                    options: [.prettyPrinted]
                ) {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                if let jsonObject = try? JSONSerialization.jsonObject(
                    with: data, options: []
                ) {
                    if let data = try? JSONSerialization.data(
                        withJSONObject: jsonObject,
                        options: [.prettyPrinted]
                    ) {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            })
            .decode(type: T.self, decoder: Self.decoder)
            .eraseToAnyPublisher()
    }

    func create<T: Encodable, R: Decodable>(_ value: T, responseType: R.Type, on url: URL) -> AnyPublisher<R, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? Self.encoder.encode(value)
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        if let data = request.httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(
                with: data, options: []
            ) {
                if let data = try? JSONSerialization.data(
                    withJSONObject: jsonObject,
                    options: [.prettyPrinted]
                ) {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                if let jsonObject = try? JSONSerialization.jsonObject(
                    with: data, options: []
                ) {
                    if let data = try? JSONSerialization.data(
                        withJSONObject: jsonObject,
                        options: [.prettyPrinted]
                    ) {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            })
            .decode(type: R.self, decoder: Self.decoder)
            .eraseToAnyPublisher()
    }

    func fetch<T: Decodable>(_ type: T.Type = T.self, from url: URL) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: url)
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: Self.decoder)
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
                let result = Result { try Self.decoder.decode(T.self, from: data) }
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        .resume()
    }
    
}
