//
//  MapView.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 28.04.2021.
//

import UIKit
import MapKit

final class MapView: UIView {

    // MARK: - Private Properties

    private(set) lazy var mapView: MKMapView = {
       let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Private methods

    private func setup() {
        backgroundColor = UIColor.white

        addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: leftAnchor),
            mapView.rightAnchor.constraint(equalTo: rightAnchor),
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
