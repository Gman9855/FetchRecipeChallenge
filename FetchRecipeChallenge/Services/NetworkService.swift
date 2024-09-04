//
//  NetworkService.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed(Error)
    case invalidResponse
    case unknown(Error)
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: String, method: String, headers: [String: String]?, body: Data?) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request<T: Decodable>(_ endpoint: String, method: String = "GET", headers: [String: String]? = nil, body: Data? = nil) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch let decodingError {
                throw NetworkError.decodingFailed(decodingError)
            }
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
