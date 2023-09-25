//
//  Services.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 25/09/2023.
//

import Foundation

class MoviesDataManager {
    
    static var shared = MoviesDataManager()
    
    var movies: [Movie]
    
    private init() {
        movies = [
            // Fantasies
            .init(name: "The Lord of the Rings: The Fellowship of the Ring", category: .fantasy, releaseDate: 2001, feedBacks: [], filmImages: FilmImages.lordOfRings1),
            .init(name: "The Lord of the Rings: The Two Towers", category: .fantasy, releaseDate: 2002, feedBacks: [], filmImages: FilmImages.lordOfRings2),
            .init(name: "The Lord of the Rings: The Fellowship of the Ring", category: .fantasy, releaseDate: 2001, feedBacks: [], filmImages: FilmImages.lordOfRings3),
            
            // Thrillers
            .init(name: "Get Out!", category: .thriller, releaseDate: 2017, feedBacks: [], filmImages: FilmImages.getOut),
            .init(name: "Joker", category: .thriller, releaseDate: 2019, feedBacks: [], filmImages: FilmImages.joker),
            .init(name: "Now You See Me",category: .thriller, releaseDate: 2013, feedBacks: [], filmImages: FilmImages.nowYouSeeMe),
            .init(name: "Split", category: .thriller, releaseDate: 2016, feedBacks: [], filmImages: FilmImages.split),
            
            // Horrors
            .init(name: "It", category: .horror, releaseDate: 2017, feedBacks: [], filmImages: FilmImages.it),
            .init(name: "Saw", category: .horror, releaseDate: 2004, feedBacks: [], filmImages: FilmImages.saw),
            .init(name: "The Black Phone", category: .horror, releaseDate: 2021, feedBacks: [], filmImages: FilmImages.theBlackPhone),
            .init(name: "The Ring", category: .horror, releaseDate: 2002, feedBacks: [], filmImages: FilmImages.theRing)
        ]
    }
}
