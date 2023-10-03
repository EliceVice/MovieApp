//
//  ReviewsTableVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 03/10/2023.
//

import UIKit

class ReviewsTableVC: UITableViewController {

    var feedbacks: [Feedback]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
    }

    #if DEBUG
    deinit {
        print("deinit", self)
    }
    #endif
    
}


// MARK: - tableView datasource

extension ReviewsTableVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedbacks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else { fatalError("Didn't get the cell") }
        
        let rating = feedbacks[indexPath.row].rating
        let review = feedbacks[indexPath.row].review
        
        // Configure the cell...
        cell.configure(rating: rating, review: review)

        return cell
    }
}

