//
//  DetailVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 26/09/2023.
//

import UIKit

final class DetailVC: UIViewController {

    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var topGradientImageView: UIImageView!
    @IBOutlet private weak var bottomGradientImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    
    @IBOutlet private weak var releaseDateView: UIView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    @IBOutlet private weak var categoryView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    @IBOutlet private weak var descTextView: UITextView!
    
    @IBOutlet private weak var leaveReviewButton: UIButton!
    @IBOutlet private weak var showReviewsButton: UIButton!
    
    var movieIndex: Int?
    private var movie: Movie?
        
    // Using viewWillLayoutSubviews, because it will be called every time this vc appears, we need to update the MoviesDataManager.shared.movies every time after coming back from LeaveReviewVC (but viewDidLoad would be called only one time)
    override func viewWillLayoutSubviews() {
        
        // Set the movie after movieIndex was passed
        if let movieIndex { movie = MoviesDataManager.shared.movies[movieIndex] }
        else { fatalError("movieIndex is nil - DetailVC") }
        
        // UI
        setupMainImageView()
        setupGradientImageViews()
        setupLabels()
        setupDescTF()
        setupBadgeViews()
        setupButtons()
        configureUIWithMovieInfo()
    }
    
    @IBAction func leaveReviewButtonTapped() {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let leaveReviewVC = storyboard.instantiateViewController(identifier: "LeaveReviewVC") as? LeaveReviewVC else {
            fatalError("Didn't get the controller LeaveReviewVC")
        }
        
        // Passing the movieIndex
        if let movie {
            let movieIndex = MoviesDataManager.shared.movies.firstIndex(of: movie)
            leaveReviewVC.movieIndex = movieIndex
        }
        
        navigationController?.pushViewController(leaveReviewVC, animated: true)
    }
    
    @IBAction func showReviewsButtonTapped() {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let reviewsTableVC = storyboard.instantiateViewController(identifier: "ReviewsTableVC") as? ReviewsTableVC else {
            fatalError("Didn't get the controller LeaveReviewVC")
        }
        
        reviewsTableVC.feedbacks = movie?.feedBacks
        
        navigationController?.pushViewController(reviewsTableVC, animated: true)
    }
    
    // Handling updating the imageViews image depending on the theme
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // The interface style has changed, update the image here
            setupGradientImageViews()
        }
    }
    
    #if DEBUG
    deinit {
        print("deinit", self)
    }
    #endif
    
}


// MARK: - Configuring the UI

extension DetailVC {
    
    private func setupMainImageView() {
        mainImageView.contentMode = .scaleAspectFill
    }
    
    // Setting up the gradient ImageViews depending on the current theme
    private func setupGradientImageViews() {
        if traitCollection.userInterfaceStyle == .dark {
            topGradientImageView.image    = UIImage(named: "TopGradientDark")
            bottomGradientImageView.image = UIImage(named: "BottomGradientDark")
            topGradientImageView.alpha    = 0.9
            bottomGradientImageView.alpha = 0.9
        } else {
            topGradientImageView.alpha    = 0
            bottomGradientImageView.alpha = 0
        }
    }
    
    private func setupLabels() {
        nameLabel.textColor = .white
        companyLabel.textColor = .white
    }
    
    private func setupDescTF() {
        descTextView.layer.borderColor = UIColor.systemGray.cgColor
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.cornerRadius = 5
        descTextView.layer.backgroundColor = UIColor.systemGray.withAlphaComponent(0.15).cgColor
    }
    
    // Setting up the badge Views depending on the current theme
    private func setupBadgeViews() {
        [releaseDateView, categoryView, ratingView].forEach {
            $0?.layer.cornerRadius = ($0?.bounds.height ?? 0) / 3
            
            if traitCollection.userInterfaceStyle == .dark {
                $0?.alpha = 0.6
                $0?.backgroundColor = .systemGray6
            } else {
                $0?.alpha = 0.7
                $0?.backgroundColor = .systemGray3
            }
        }
    }
    
    private func setupButtons() {
        guard let movie else { fatalError("Didn't get the movie") }
        
        showReviewsButton.isEnabled = !movie.feedBacks.isEmpty
        showReviewsButton.setTitle("Show The Reviews (\(movie.feedBacks.count))", for: .normal)
    }
    
    // Configuring the UI with information about the movie
    private func configureUIWithMovieInfo() {
        mainImageView.image   = movie?.filmImages.mainImage
        nameLabel.text        = movie?.name
        companyLabel.text     = movie?.company
        releaseDateLabel.text = movie?.releaseDate.description
        categoryLabel.text    = movie?.category.rawValue
        ratingLabel.text      = movie?.averageRating?.description ?? "..."
        descTextView.text     = movie?.description
    }
}

