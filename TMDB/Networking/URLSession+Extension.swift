//
//  URLSession+Extension.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

enum NetworkingError: String, Error {
    case badUrl
    case invalidData
    case decoding
    var description: String {
        return self.rawValue
    }
}

extension URLSession {
    func request<T: Decodable>(url: URL?,
                               expecting: T.Type,
                               httpMethod: String = "GET",
                               completion: @escaping(Result<T, Error>) -> Void) {
        do {
            let url = try retrieveValidURL(url)
            let request = createURLRequest(url, httpMethod)
            try performDataTask(from: request, expectingObject: expecting) { result in
                completion(result)
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    private func retrieveValidURL(_ url: URL?) throws -> URL {
        guard let url = url else {
            throw NetworkingError.badUrl
        }
        return url
    }
    
    private func createURLRequest(_ url: URL, _ httpMethod: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        setupRequestHttpHeader(&urlRequest)
        return urlRequest
    }
    
    private func setupRequestHttpHeader(_ urlRequest: inout URLRequest) {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(PlistFiles.authorization, forHTTPHeaderField: "Authorization")
    }
    
    private func performDataTask<T: Decodable>(from urlRequest: URLRequest,
                                               expectingObject expecting: T.Type,
                                               result completion: @escaping(Result<T, Error>) -> Void) throws {
        let dataTask = dataTask(with: urlRequest) { [weak self] data, _, error in
            do {
                try self?.retrieveError(error)
                if let data = try self?.retrieveValidDataFromRequest(data) {
                    if let result = try self?.decodeExpectingObject(expectingObject: expecting, from: data) {
                        completion(.success(result))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    private func retrieveError(_ error: Error?) throws {
        if let error = error {
            throw error
        }
    }
    
    private func retrieveValidDataFromRequest(_ data: Data?) throws -> Data {
        guard let data = data else {
            throw NetworkingError.invalidData
        }
        return data
    }
    
    private func decodeExpectingObject<T: Decodable>(expectingObject expecting: T.Type, from data: Data ) throws -> T {
        do {
            return try JSONDecoder().decode(expecting, from: data)
        } catch {
            throw error
        }
    }
    
    private func logError(_ error: Error) {
        debugPrint(error)
    }
}
