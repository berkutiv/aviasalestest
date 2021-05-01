//
//  CityAnnotation.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation
import MapKit

enum CustomAnnotationType: String {
    case startCity
    case destinationCity
    case plane
}

final class CustomAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var type: CustomAnnotationType
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, type: CustomAnnotationType, image: UIImage?) {
        self.coordinate = coordinate
        self.type = type
        self.image = image
        super.init()
    }

}
