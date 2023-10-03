//
//  MovieCell.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescLabel: UILabel!
    
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var movieCompanyLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        companyView.layer.cornerRadius = companyView.bounds.height / 2
        ratingView.layer.cornerRadius = ratingView.bounds.height / 2
    }
    

    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    */
    
    func configure(movieName: String, movieCompanyName: String, movieDescription: String, movieImage: UIImage, movieAverageRating: Double?) {
        movieNameLabel.text     = movieName
        movieCompanyLabel.text  = movieCompanyName
        movieDescLabel.text     = movieDescription
        movieImageView.image    = movieImage
        movieRatingLabel.text   = movieAverageRating?.description ?? "..."
    }
    
}
