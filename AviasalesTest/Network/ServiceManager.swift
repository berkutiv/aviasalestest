//
//  ServiceManager.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

class ServiceManager {

    public static let shared: ServiceManager = ServiceManager()

    public var baseURL: String = "http://places.aviasales.ru/"
}

extension ServiceManager {

    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) -> URLSessionDataTask {

        let task = URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard
                let data = data,
                  let decodedModel = try? decoder.decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)

                completion(Result.failure(error))
                return
            }

            completion(Result.success(decodedModel))

        }
        task.resume()
        return task
    }
}
