//
//  MapProtocols.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import MapKit

protocol MapViewInput: AnyObject {
    var customView: MapView { get }

    func setAnnotations(polyline: MKGeodesicPolyline, annotations: [CustomAnnotation], region: MKCoordinateRegion)
}

protocol MapViewOutput: AnyObject {
    func viewDidLoad()
}

protocol MapRouterInput: AnyObject {
}
