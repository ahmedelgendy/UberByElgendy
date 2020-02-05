//
//  TripSearchResultsViewController.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

class TripSearchResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tripStatusSegmentedControl: UISegmentedControl!
    
    let viewModel: TripSearchResultsViewModel
    let cellId: String = "TripSearchResultTableViewCell"
    
    // MARK: - init
    init(viewModel: TripSearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleTableState()
        viewModel.reloadTableView = { [weak self] in
            self?.title = self?.viewModel.title
            self?.tableView.reloadData()
            self?.handleTableState()
        }
        setupUI()
    }
    
    private func handleTableState() {
        if self.viewModel.numberOfItems == 0 {
            let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 30)
            let label = UILabel(frame: frame)
            label.text = "No Trips Found"
            label.textColor = .darkGray
            label.textAlignment = .center
            label.center = self.tableView.center
            label.sizeToFit()
            self.tableView.backgroundView = label
        } else {
            self.tableView.backgroundView = nil
        }
    }
    
    @objc private func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        let status: TripStatus = segmentedControl.selectedSegmentIndex == 0 ? .completed : .canceled
        viewModel.changeTripStatus(status)
    }
    
}

// MARK: - UI Setup
extension TripSearchResultsViewController {
    
    private func setupUI() {
        title = viewModel.title
        setupTableView()
        setupSegmentedControl()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    private func setupSegmentedControl() {
        tripStatusSegmentedControl.setTitle(
            viewModel.completedSegmentTitle,
            forSegmentAt: 0
        )
        tripStatusSegmentedControl.setTitle(
            viewModel.cancelledSegmentTitle,
            forSegmentAt: 1
        )
        tripStatusSegmentedControl.addTarget(
            self,
            action: #selector(segmentedControlChanged(_:)),
            for: .valueChanged
        )
    }
}

// MARK: - TableViewDelegate
extension TripSearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TripSearchResultTableViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.dataForRowAt(index: indexPath.row)
        cell.configure(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = viewModel.dataForRowAt(index: indexPath.row)
        let viewModel = TripDetailsViewModel(trip: trip, googleMapsProvider: GoogleMapsProvider())
        let vc = TripDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
