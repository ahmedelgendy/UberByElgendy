//
//  TripSearchViewController.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

class TripSearchViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var selectedDistanceLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var selectedTimeLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var incluedCanceledTripsSwitch: UISwitch!
    
    
    // MARK: - properties
    private var viewModel: TripSearchViewModel
    
    // MARK: - init
    init(viewModel: TripSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetch()
        viewModel.onTripsFetched = { }
    }
    
    @objc private func includeCanceledTripsChanged(_ uiswitch: UISwitch) {
        viewModel.includeCanceledTrips(uiswitch.isOn)
    }
    // MARK: - IBAction
    // distanceView Tap Gesture Recognizer
    @IBAction func distanceViewTapped(_ sender: Any) {
        showDistanceViewAlert()
    }
    
    @IBAction func selectTimeViewTapped(_ sender: Any) {
        showSelectTimeViewAlert()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        perfromTripsSEarch()
    }
    
    // MARK: -
    fileprivate func showSelectTimeViewAlert() {
        var actions = [UIAlertAction]()
        for (index, time) in TimeOption.allCases.enumerated() {
            let action = UIAlertAction(title: time.title, style: .default, handler: { _ in
                self.selectedTimeLabel.text = time.title
                self.viewModel.setTime(TimeOption(rawValue: index))
            })
            actions.append(action)
        }
        let alert = Alert.createActionSheet(title: "Choose Time", actions: actions)
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func showDistanceViewAlert() {
        var actions = [UIAlertAction]()
        for (index, distance) in DistanceOption.allCases.enumerated() {
            let action = UIAlertAction(title: distance.title, style: .default, handler: { _ in
                self.selectedDistanceLabel.text = distance.title
                self.viewModel.setDistance(DistanceOption(rawValue: index))
            })
            actions.append(action)
        }
        let alert = Alert.createActionSheet(title: "Choose Distance", actions: actions)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func perfromTripsSEarch() {
        view.endEditing(true)
        let viewModel = self.viewModel.createTripSearchResultsViewModel()
        let viewController = TripSearchResultsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UI Setup
extension TripSearchViewController {
    fileprivate func setupUI() {
        title = "Trip Search"
        setupSerachButton()
        setupSeachBar()
        setupSwitch()
    }
    
    private func setupSerachButton() {
        searchButton.layer.cornerRadius = 5
    }
    
    private func setupSeachBar() {
        searchBar.delegate = self
        searchBarContainer.layer.cornerRadius = 10
        searchBarContainer.layer.borderColor = UIColor.lightGray.cgColor
        searchBarContainer.layer.borderWidth = 1
    }
    
    private func setupSwitch() {
        incluedCanceledTripsSwitch.addTarget(
            self,
            action: #selector(includeCanceledTripsChanged(_:)),
            for: .valueChanged
        )
    }
}

// MARK: - UISearchBarDelegate
extension TripSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setSearchKeyword(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        perfromTripsSEarch()
    }
}
