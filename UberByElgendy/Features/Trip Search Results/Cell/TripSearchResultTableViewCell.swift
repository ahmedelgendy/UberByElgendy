//
//  TripSearchResultTableViewCell.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

class TripSearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var pickupLocationLabel: UILabel!
    @IBOutlet weak var dropOffLocationLabel: UILabel!
    @IBOutlet weak var ratingStackView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: Trip) {
        startTimeLabel.text = data.pickupDate.formattedDate()
        pickupLocationLabel.text = data.pickupLocation
        dropOffLocationLabel.text = data.dropoffLocation
        
        switch data.status {
        case .canceled:
            costLabel.text = ""
            ratingStackView.isHidden = true
        case .completed:
            costLabel.text = data.finalCost
            ratingStackView.isHidden = false
            ratingStackView.rate(data.driverRating)
        }
    }
    
}
