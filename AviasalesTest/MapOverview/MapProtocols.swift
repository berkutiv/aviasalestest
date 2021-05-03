//
//  MapProtocols.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import MapKit

protocol MapViewInput: AnyObject {
    var customView: MapView { get }

    func setMapComponents(mapRenderingComponents: MapRenderingComponents)
}

protocol MapViewOutput: AnyObject {
    func viewDidLoad()
}

protocol MapRouterInput: AnyObject {
}
