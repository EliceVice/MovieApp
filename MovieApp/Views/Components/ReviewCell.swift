//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 03/10/2023.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(rating: Double?, review: String?) {
        ratingLabel.text = rating?.description
        reviewLabel.text = review
    }
    
    func setupUI() {
        ratingView.layer.cornerRadius = ratingView.frame.height / 2
    }
    
}
