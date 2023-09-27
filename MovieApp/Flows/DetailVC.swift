//
//  DetailVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 26/09/2023.
//

import UIKit

final class DetailVC: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var releaseDateView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var leaveReviewButton: UIButton!
    @IBOutlet weak var showReviewsButton: UIButton!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        setupDescTF()
        setupBadgeViews()
        setupMainImageView()
        configureUIWithMovieInfo()
        
        
    }

}


// MARK: - Configuring the UI

extension DetailVC {
    
    private func setupMainImageView() {
        mainImageView.contentMode = .scaleAspectFill
    }
    
    private func setupDescTF() {
        descTextView.layer.borderColor = UIColor.systemGray.cgColor
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.cornerRadius = 5
        descTextView.layer.backgroundColor = UIColor.systemGray.withAlphaComponent(0.15).cgColor
    }
    
    private func setupBadgeViews() {
        [releaseDateView, categoryView, ratingView].forEach {
            $0?.layer.cornerRadius = ($0?.bounds.height ?? 0) / 3
        }
    }
    
    // Configuring the UI with information about the movie
    private func configureUIWithMovieInfo() {
        mainImageView.image = movie?.filmImages.mainImage
        nameLabel.text = movie?.name
        companyLabel.text = movie?.company
        releaseDateLabel.text = movie?.releaseDate.description
        categoryLabel.text = movie?.category.rawValue
        ratingLabel.text = movie?.averageRating?.description ?? "..."
        descTextView.text = movie?.description
    }
}

