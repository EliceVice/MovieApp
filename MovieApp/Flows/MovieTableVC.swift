//
//  MovieTableVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import UIKit

final class MovieTableVC: UITableViewController {
    
    private var movies: [Movie] { MoviesDataManager.shared.movies }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
}


// MARK: - Table view data source

extension MovieTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        Category.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = Category.allCases[section]
        let moviesInCategory = movies.filter { $0.category == category }
        return moviesInCategory.count
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = Category.allCases[section]
        return category.rawValue
    }
    */
    
    // Creating custom view for the Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = Category.allCases[section]
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.alpha = 0.5
        label.text = category.rawValue
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError("Didn't get the cell") }
        
        // Getting the movie by category
        let category = Category.allCases[indexPath.section]
        let moviesInCategory = movies.filter { $0.category == category }
        let movie = moviesInCategory[indexPath.row]
        
        cell.configure(
            movieName: movie.name,
            movieCompanyName: movie.company,
            movieDescription: movie.description,
            movieImage: movie.filmImages.tableImage,
            movieAverageRating: movie.averageRating
        )
        
        return cell
    }
    
}


// MARK: - Table view delegate

extension MovieTableVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {
            fatalError("Didn't get the controller")
        }
        
        // Getting the selected movie
        let category = Category.allCases[indexPath.section]
        let moviesInCategory = movies.filter { $0.category == category }
        let movie = moviesInCategory[indexPath.row]
        
        // Passing the movie
        detailVC.movie = movie
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: - Custom methods

extension MovieTableVC {

//    private func calculateAverageRating(for movie: Movie) -> Double? {
//
//        // Getting existing ratings of the movie
//        let validRatings = movie.feedBacks.compactMap() { $0.rating }
//
//        // Check if there are any ratings on the movie
//        if validRatings.isEmpty { return nil }
//
//        // Calculating the average rating
//        let totalRating = validRatings.reduce(0, +)
//        let average = totalRating / Double(validRatings.count)
//
//        return average
//    }
}
