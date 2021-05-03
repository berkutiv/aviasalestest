//
//  ViewController.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 28.04.2021.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    // MARK: - Public Properties

    var output: MapViewOutput!

    // MARK: - Private Properties

    private(set) lazy var customView = view as! MapView
    private var geodesicPolyline: MKGeodesicPolyline?
    private var planeAnnotation: CustomAnnotation?
    private var planeMovingStep = 15
    private var currentPlanePosition = 0

    // MARK: - Lifecycle

    override func loadView() {
        view = MapView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output.viewDidLoad()
    }

    // MARK: - Private methods

    private func configure() {
        customView.mapView.delegate = self
    }

    private func updatePlanePosition() {
        guard
            let polyline = geodesicPolyline,
            let planeAnnotation = planeAnnotation,
            currentPlanePosition + planeMovingStep < polyline.pointCount
            else { return }

        let points = polyline.points()
        let currentPlaneMapPoint = points[currentPlanePosition]
        currentPlanePosition += planeMovingStep
        let nextPlaneMapPoint = points[currentPlanePosition]

        let directionBetweenCoordinates = directionBetweenPoints(startPoint: currentPlaneMapPoint, destinationPoint: nextPlaneMapPoint)
        planeAnnotation.coordinate = nextPlaneMapPoint.coordinate

        let mapDirection = customView.mapView.camera.heading
        let calculatedAngle = directionBetweenCoordinates - mapDirection
        let radiansAngle = degreesToRadians(CGFloat(calculatedAngle))
        if let annotationView = customView.mapView.view(for: planeAnnotation) {
            annotationView.transform = CGAffineTransform(rotationAngle: radiansAngle)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) { [weak self] in
            self?.updatePlanePosition()
        }
    }

    private func directionBetweenPoints(startPoint: MKMapPoint, destinationPoint: MKMapPoint) -> CLLocationDirection {
        let x = destinationPoint.x - startPoint.x
        let y = destinationPoint.y - startPoint.y

        let angle = CLLocationDirection(radiansToDegrees(CGFloat(atan2(y, x))).truncatingRemainder(dividingBy: 360))
        return angle
    }

    private func radiansToDegrees(_ radians: CGFloat) -> CGFloat {
        return radians * 180 / .pi
    }

    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return degrees * .pi / 180
    }

}

// MARK: - MapViewInput

extension MapViewController: MapViewInput {

    func setMapComponents(mapRenderingComponents: MapRenderingComponents) {
        geodesicPolyline = mapRenderingComponents.polyline
        customView.mapView.addOverlay(mapRenderingComponents.polyline)

        customView.mapView.addAnnotations(mapRenderingComponents.cityAnnotations)

        planeAnnotation = mapRenderingComponents.planeAnnotation
        customView.mapView.addAnnotation(mapRenderingComponents.planeAnnotation)

        customView.mapView.setRegion(mapRenderingComponents.region, animated: true)
        updatePlanePosition()
    }

}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKGeodesicPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.lineDashPattern = [0, 5]
            renderer.lineWidth = 2
            renderer.strokeColor = .aviasalesBlue
            return renderer
        }
        return MKOverlayRenderer()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }

        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotation.type.rawValue)
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: customAnnotation.type.rawValue)

        annotationView.image = customAnnotation.image

        if customAnnotation.type == .plane {
            annotationView.isSelected = true
        }

        return annotationView
    }

}
