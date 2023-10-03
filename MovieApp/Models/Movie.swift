//
//  Movie.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import UIKit

struct Movie: Equatable {

    let name: String
    let category: Category
    let company: String
    let description: String
    let releaseDate: Int
    var feedBacks: [Feedback]
    let filmImages: (tableImage: UIImage, mainImage: UIImage)
    
    // Property of the average rating
    var averageRating: Double? {
        let validRatings = self.feedBacks.compactMap { $0.rating }

        // Check if there are any ratings on the movie
        if validRatings.isEmpty { return nil }

        // Calculating the average rating
        let totalRating = validRatings.reduce(0, +)
        let average = totalRating / Double(validRatings.count)

        return average
    }
    
    // Manual implementation of the equality operator
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.name == rhs.name &&
               lhs.category == rhs.category &&
               lhs.company == rhs.company &&
               lhs.description == rhs.description &&
               lhs.releaseDate == rhs.releaseDate &&
               lhs.feedBacks == rhs.feedBacks &&
               lhs.filmImages.tableImage == rhs.filmImages.tableImage &&
               lhs.filmImages.mainImage == rhs.filmImages.mainImage
    }
}

