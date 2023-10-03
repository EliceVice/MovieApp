//
//  LeaveReviewVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 28/09/2023.
//

import UIKit

class LeaveReviewVC: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    @IBOutlet private weak var ratingStackView: UIStackView!
    @IBOutlet private weak var reviewTextView: UITextView!
    
    @IBOutlet private weak var doneButton: UIButton!
    
    private var isReviewValid = false { didSet { updateDoneButtonState() } }
    private var rating = 0 { didSet { updateDoneButtonState() } }
    
    var movieIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        reviewTextView.delegate = self
        
        // UI
        setupReviewTF()
        setupRatingStack()
        setupDoneButton()
        
        // Keyboard
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func doneButtonTapped() {
        let feedback = Feedback(
            rating: Double(rating),
            review: reviewTextView.text
        )
        
        if let movieIndex {
            
            // Getting the current movie
            var currentMovie = MoviesDataManager.shared.movies[movieIndex]
            
            // Adding new feedback
            currentMovie.feedBacks.append(feedback)
            
            // Updating the movie in the storage
            MoviesDataManager.shared.movies[movieIndex] = currentMovie
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    // When LeaveReviewVC is getting deallocated, clean up observers and gesture recognizers
    deinit {

        // Cleaning NotificationCenter
        NotificationCenter.default.removeObserver(self)
        
        // Removing gesture recognizers
        for subview in ratingStackView.arrangedSubviews {
            if let tapRecognizer = subview.gestureRecognizers?.first {
                subview.removeGestureRecognizer(tapRecognizer)
            }
        }
        
        #if DEBUG
        print("deinit", self)
        #endif
    }
    
}


// MARK: - Setup UI methods

extension LeaveReviewVC {
    
    private func setupReviewTF() {
        reviewTextView.layer.borderColor = UIColor.systemGray.cgColor
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.cornerRadius = 10
        reviewTextView.layer.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        
        reviewTextView.text = "Enter your opinion here..."
        reviewTextView.textColor = .systemGray
    }
    
    private func setupRatingStack() {
        ratingStackView.arrangedSubviews.forEach {
            $0.isUserInteractionEnabled = true
            $0.alpha = 0.3
            $0.tintColor = .systemGray
            
            // And also adding a tap gesture, so we can interract with star images
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(starTapped))
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func setupDoneButton() {
        doneButton.layer.cornerRadius = doneButton.frame.height / 5
        doneButton.isEnabled = false
        doneButton.backgroundColor = .systemGray.withAlphaComponent(0.2)
    }
    
}


// MARK: - UITextView delegate (adding placeholder)

extension LeaveReviewVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your opinion here..." {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter your opinion here..."
            textView.textColor = .systemGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }

        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let review = textView.text {
            isReviewValid = Validator.checkIsReviewValid(review: review)
        } else {
            isReviewValid = false
        }
    }
    
}


// MARK: - Handling Keyboard

extension LeaveReviewVC {
    
    // MARK: User tap
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        // (NOTE FOR ME): You are allowing other gestures to be recognized even if this tap gesture is recognized. This is important in scenarios where you want to handle the tap gesture but still allow other gestures (such as scrolling) to be recognized simultaneously. The 'cancelsTouchesInView' being set to false ensures that other touches, such as scrolling, are not interfered with by this tap gesture.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Adding inset to scrollView when keyboard appears
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
}


// MARK: - Target methods

extension LeaveReviewVC {
    
    // (NOTE FOR ME): This method calls endEditing(true) on the view, which will cause any active text fields or text views within the view to resign their first responder status, dismissing the keyboard.
    // Method that is called when the main 'view' was tapped
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            fatalError("Didn't get the keyboard size")
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInset
    }
    
    // Method that is called when star was tapped
    @objc private func starTapped(sender: UITapGestureRecognizer) {
        
        guard let tappedStar = sender.view,
              let index = ratingStackView.arrangedSubviews.firstIndex(of: tappedStar)
        else { return }
        
        // Clear all stars to their default state (empty)
        for i in 0..<ratingStackView.arrangedSubviews.count {
            if let starImageView = ratingStackView.arrangedSubviews[i] as? UIImageView {
                starImageView.alpha = 0.3
                starImageView.tintColor = .systemGray
            }
        }
            
        // Fill stars up to the tapped star
        for i in 0...index {
            if let starImageView = ratingStackView.arrangedSubviews[i] as? UIImageView {
                starImageView.alpha = 1
                starImageView.tintColor = .yellow
            }
        }
        
        // Set the rating after tap
        rating = index + 1
    }
    
}


// MARK: - Custom functions

extension LeaveReviewVC {
    
    private func updateDoneButtonState() {
        if isReviewValid && rating != 0 {
            UIView.animate(withDuration: 0.2) {
                self.doneButton.alpha = 1
                self.doneButton.backgroundColor = .systemOrange.withAlphaComponent(0.2)
            }
            self.doneButton.isEnabled = true
        } else {
            UIView.animate(withDuration: 0.2) {
                self.doneButton.backgroundColor = .systemGray.withAlphaComponent(0.2)
            }
            self.doneButton.isEnabled = false
        }
    }
    
}
