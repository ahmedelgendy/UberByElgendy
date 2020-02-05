//
//  TripDetailsViewController.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMaps

class TripDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var pickupLocationLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    @IBOutlet weak var dropoffLocationLabel: UILabel!
    @IBOutlet weak var dropoffTimeLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var driverRatingView: RatingView!
    
    private let viewModel: TripDetailsViewModel
    private var mapBounds = GMSCoordinateBounds()
    
    // MARK: - init
    init(viewModel: TripDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension TripDetailsViewController: GMSMapViewDelegate {
    
}


// MARK: - UI Setup
extension TripDetailsViewController {
    func setupUI() {
        title = "Trip Details"
        carModelLabel.sizeToFit()
        bindData()
    }
    
    func bindData() {
        setupCarData()
        setupDriverData()
        setupMap()
        setupLabel()
        switch viewModel.tripStatus {
        case .canceled:
            costLabel.isHidden = true
            driverRatingView.isHidden = true
        case .completed:
            costLabel.text = viewModel.totalCost
            driverRatingView.rate(viewModel.driverRating)
            drawRoutes()
        }
    }
    
    private func setupLabel() {
        pickupLabel.text = viewModel.pickupDate
        costLabel.text = viewModel.totalCost
        pickupLocationLabel.text = viewModel.pickUpLocation
        pickupTimeLabel.text = viewModel.pickUpTime
        dropoffLocationLabel.text =  viewModel.dropOffLocation
        dropoffTimeLabel.text =  viewModel.dropOffTime
        distanceLabel.text = viewModel.distance
        durationLabel.text = viewModel.duration
    }
    
    private func setupCarData() {
        if let carImageUrl = viewModel.carImageUrl {
            carImageView.kf.setImage(with: carImageUrl)
        }
        carModelLabel.text = viewModel.carModel
    }
    
    private func setupDriverData() {
        if let driverPicUrl = viewModel.driverImageUrl {
            driverImageView.kf.setImage(with: driverPicUrl)
        }
        driverNameLabel.text = viewModel.driverName
    }
    
}

// MARK: - Map handling methods
extension TripDetailsViewController {
    
    private func setupMap() {
        mapView.delegate = self
        setupMarkers()
    }
    
    private func drawRoutes() {
        viewModel.fetchRoutes { [weak self] (points) in
            DispatchQueue.main.async {
                if let points = points {
                    self?.drawPath(from: points)
                }
            }
        }
    }
    
    // draw a path between two points
    private func drawPath(from points: String){
        let path = GMSPath(fromEncodedPath: points)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView
        // update camera to show the path view
        if let path = path {
            let bounds = GMSCameraUpdate.fit(GMSCoordinateBounds(path: path), withPadding: 30)
            mapView.animate(with: bounds)
        }
    }
    
    private func setupMarkers() {
        let pickupCoordinate = viewModel.pickupCoordinate()
        addMapMarker(title: "Pickup Location",
                     lat: pickupCoordinate.lat,
                     lng: pickupCoordinate.lng,
                     color: .green)
        
        let dropoffCoordinate = viewModel.dropoffCoordinate()
        addMapMarker(title: "Dropoff Location",
                     lat: dropoffCoordinate.lat,
                     lng: dropoffCoordinate.lng)
    }
    
    private func addMapMarker(title: String, lat: Double, lng: Double, color: UIColor = .red) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat,
                                                 longitude: lng)
        marker.title = title
        marker.icon = GMSMarker.markerImage(with: color)
        marker.map = mapView
        adddToMapBounds(marker.position)
    }
    
    // This function used to show all the markers in the map view
    private func adddToMapBounds(_ coordinate: CLLocationCoordinate2D) {
        mapBounds = mapBounds.includingCoordinate(coordinate)
        let cameraUpdate = GMSCameraUpdate.fit(mapBounds, withPadding: 50)
        mapView.animate(with: cameraUpdate)
    }
}
