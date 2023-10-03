//
//  MovieTableVC.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import UIKit

final class MovieTableVC: UITableViewController {
    
    private var movies: [Movie] = MoviesDataManager.shared.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    // Updating the movies and reloading the data
    override func viewWillAppear(_ animated: Bool) {
        movies = MoviesDataManager.shared.movies
        tableView.reloadData()
    }
    
    #if DEBUG
    deinit {
        print("deinit", self)
    }
    #endif
}


// MARK: - Table view data source

extension MovieTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        Category.allCases.count
    }
    
    // Getting the number of movies for the corresponding category (the order of sections is same as in 'Category' Model)
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
    
    // Configuring the cell
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
            fatalError("Didn't get the controller DetailVC")
        }
        
        // Getting the selected movie
        let category = Category.allCases[indexPath.section]
        let moviesInCategory = movies.filter { $0.category == category }
        let movie = moviesInCategory[indexPath.row]
        
        // Passing the movieIndex
        let movieIndex = MoviesDataManager.shared.movies.firstIndex(of: movie)
        detailVC.movieIndex = movieIndex
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

