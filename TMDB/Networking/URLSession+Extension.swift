//
//  URLSession+Extension.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

extension URLSession {
    func request<T: Decodable>(url: URL?,
                             expecting: T.Type,
                             completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NSError(domain: "", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(PlistFiles.authorization)", forHTTPHeaderField: "Authorization")
        
        let task = dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(NSError(domain: error.localizedDescription, code: -2)))
                } else {
                    completion(.failure(NSError(domain: "", code: -3)))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
