//
//  Movie.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import UIKit

struct Movie {
    let name: String
    let category: Category
    let releaseDate: Int
    let feedBacks: [FeedBack]
    let filmImages: (tableImage: UIImage, mainImage: UIImage)
}

enum Category: String, CaseIterable {
    case fantasy  = "Fantasy"
    case thriller = "Thriller"
    case horror   = "Horror"
}

// MARK: Getting the images from the assets
struct FilmImages {
    
    // Fantasies
    static let lordOfRings1  = (UIImage(named: "tableLordOfTheRings1")!, UIImage(named: "mainLordOfTheRings1")!)
    static let lordOfRings2  = (UIImage(named: "tableLordOfTheRings2")!, UIImage(named: "mainLordOfTheRings2")!)
    static let lordOfRings3  = (UIImage(named: "tableLordOfTheRings3")!, UIImage(named: "mainLordOfTheRings3")!)
    
    // Horrors
    static let getOut        = (UIImage(named: "tableGetOut")!, UIImage(named: "mainGetOut")!)
    static let joker         = (UIImage(named: "tableJoker")!, UIImage(named: "mainJoker")!)
    static let nowYouSeeMe   = (UIImage(named: "tableNowYouSeeMe")!, UIImage(named: "mainNowYouSeeMe")!)
    static let split         = (UIImage(named: "tableSplit")!, UIImage(named: "mainSplit")!)
    
    // Horrors
    static let it            = (UIImage(named: "tableIt")!, UIImage(named: "mainIt")!)
    static let saw           = (UIImage(named: "tableSaw")!, UIImage(named: "mainSaw")!)
    static let theBlackPhone = (UIImage(named: "tableTheBlackPhone")!, UIImage(named: "mainTheBlackPhone")!)
    static let theRing       = (UIImage(named: "tableTheRing")!, UIImage(named: "mainTheRing")!)
}
