//
//  MapPresenter.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation
import MapKit

final class MapPresenter {

    // MARK: - Public Properties

    weak var view: MapViewInput!
    var router: MapRouterInput!

    // MARK: - Private Properties

    private var startCity: CityViewModel
    private var destinationCity: CityViewModel

    // MARK: - Initializers

    init(mapInputModel: MapInputModel) {
        self.startCity = mapInputModel.startCity
        self.destinationCity = mapInputModel.destinationCity
    }

    // MARK: - Private Methods

    private func createMapItems() {
        let startCityImage = createCityView(with: startCity.iata)
        let startCityAnnotation = CustomAnnotation(coordinate: startCity.coordinates, type: .startCity, image: startCityImage)

        let destinationCityImage = createCityView(with: destinationCity.iata)
        let destinationCityAnnotation = CustomAnnotation(coordinate: destinationCity.coordinates, type: .destinationCity, image: destinationCityImage)

        let planeAnnotation = CustomAnnotation(coordinate: startCity.coordinates, type: .plane, image: UIImage(named: "plane"))

        var coordinates = [startCity.coordinates, destinationCity.coordinates]
        let polyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)

        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        let region = MKCoordinateRegion(center: startCity.coordinates, span: span)

        let mapRenderingComponents = MapRenderingComponents(polyline: polyline, region: region, cityAnnotations: [startCityAnnotation, destinationCityAnnotation], planeAnnotation: planeAnnotation)

        view.setMapComponents(mapRenderingComponents: mapRenderingComponents)
    }

    private func createCityView(with iata: String?) -> UIImage {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        label.textColor = .aviasalesBlue
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.text = iata

        label.center = view.center
        view.addSubview(label)

        view.layer.borderColor = UIColor.aviasalesBlue.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true

        return view.asImage()
    }

}

// MARK: - MapViewOutput

extension MapPresenter: MapViewOutput {

    func viewDidLoad() {
        createMapItems()
    }

}
