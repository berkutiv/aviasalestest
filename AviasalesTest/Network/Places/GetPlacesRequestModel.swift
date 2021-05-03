//
//  GetPlacesRequestModel.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

class GetPlacesRequestModel: RequestModel {

    private var text: String

    init(text: String) {
        self.text = text
    }

    override var method: RequestHTTPMethod {
        return .get
    }

    override var path: String {
        return Constants.NetworkPaths.places.rawValue
    }

    override var parameters: [String : Any?] {
        return [
            "term": text
        ]
    }
    
}
