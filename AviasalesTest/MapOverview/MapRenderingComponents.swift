//
//  MapRenderingComponents.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 03.05.2021.
//

import MapKit

struct MapRenderingComponents {
    let polyline: MKGeodesicPolyline
    let region: MKCoordinateRegion
    let cityAnnotations: [CustomAnnotation]
    let planeAnnotation: CustomAnnotation
}
