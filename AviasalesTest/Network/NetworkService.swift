//
//  NetworkService.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

class NetworkService {

    class func places(text: String, completion: @escaping(Swift.Result<[CityModel], ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: GetPlacesRequestModel(text: text), completion: completion)
        return request
    }
}
