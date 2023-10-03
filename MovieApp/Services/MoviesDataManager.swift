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
            .init(
                name: "The Lord of the Rings: The Fellowship of the Ring",
                category: .fantasy,
                company: "New Line Cinema",
                description: "A shy young hobbit named Frodo Baggins, accompanied by a wizard, an elf, a dwarf, two men and three loyal hobbit friends, set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.",
                releaseDate: 2001,
                feedBacks: [],
                filmImages: MovieImages.lordOfRings1
            ),
            .init(
                name: "The Lord of the Rings: The Two Towers",
                category: .fantasy,
                company: "New Line Cinema",
                description: "Frodo and the other members of the Fellowship continue on their quest to destroy the One Ring – but on separate paths. Their destinies lie at two towers – Orthanc Tower in Isengard, where Saruman awaits, and Sauron's fortress at Barad-dur.",
                releaseDate: 2002,
                feedBacks: [],
                filmImages: MovieImages.lordOfRings2
            ),
            .init(
                name: "The Lord of the Rings: The Fellowship of the Ring",
                category: .fantasy, company: "New Line Cinema",
                description: "In the conclusion of J.R.R. Tolkien's epic masterpiece, hobbits Frodo and Sam reach Mordor in their quest to destroy the Ring of Power, while Aragorn leads the forces of good against Sauron's evil army at the stone city of Minas Tirith.",
                releaseDate: 2003,
                feedBacks: [],
                filmImages: MovieImages.lordOfRings3
            ),
            
            // Thrillers
            .init(
                name: "Get Out!",
                category: .thriller,
                company: "Universal Pictures",
                description: "A young African American man visits his Caucasian girlfriend's cursed family estate. Includes Alternate Ending, Deleted Scenes, and more.",
                releaseDate: 2017,
                feedBacks: [],
                filmImages: MovieImages.getOut
            ),
            .init(
                name: "Joker",
                category: .thriller,
                company: "Warner Bros",
                description: "“Joker” is an original, standalone story. Arthur Fleck (Joaquin Phoenix), a man disregarded by society, is not only a gritty character study, but also a broader cautionary tale.",
                releaseDate: 2019,
                feedBacks: [],
                filmImages: MovieImages.joker
            ),
            .init(
                name: "Now You See Me",
                category: .thriller,
                company: "Summit Entertainment",
                description: "Mystery thriller starring Mark Ruffalo and Woody Harrelson. Four talented magicians are plucked from obscurity to becomes the Four Horsemen - a group of stage illusionists who soon attract the attention of the FBI...is it magic, or crime?",
                releaseDate: 2013,
                feedBacks: [],
                filmImages: MovieImages.nowYouSeeMe
            ),
            .init(
                name: "Seven",
                category: .thriller,
                company: "New Line Cinema",
                description: "Two homicide detectives (Morgan Freeman and Brad Pitt) are on a desperate hunt for a serial killer whose crimes are based on the \"seven deadly sins\".",
                releaseDate: 1995,
                feedBacks: [],
                filmImages: MovieImages.seven
            ),
            .init(
                name: "Split",
                category: .thriller,
                company: "Blumhouse Productions",
                description: "Though Kevin (James McAvoy) has evidenced 23 personalities to his trusted psychiatrist, Dr. Fletcher (Betty Buckley), there remains one still submerged who is set to materialize and dominate all the others.",
                releaseDate: 2016,
                feedBacks: [],
                filmImages: MovieImages.split
            ),
            
            // Horrors
            .init(
                name: "It",
                category: .horror,
                company: "New Line Cinema",
                description: "When children in town begin to disappear, a group of young kids is faced with their biggest fears as they square off against evil clown, Pennywise. Based on the Stephen King novel.",
                releaseDate: 2017,
                feedBacks: [],
                filmImages: MovieImages.it
            ),
            .init(
                name: "Saw",
                category: .horror,
                company: "Twisted Pictures",
                description: "Two strangers awaken in a room with no memory of how they got there and soon discover that they are pawns in a deadly game orchestrated by a serial killer.",
                releaseDate: 2004,
                feedBacks: [],
                filmImages: MovieImages.saw
            ),
            .init(
                name: "The Black Phone",
                category: .horror,
                company: "Universal Pictures",
                description: "A teenage boy is abducted by a sadistic killer (Ethan Hawke) and discovers a phone in his basement cell that allows him to communicate with the killer's previous victims.",
                releaseDate: 2021,
                feedBacks: [],
                filmImages: MovieImages.theBlackPhone
            ),
            .init(
                name: "The Ring",
                category: .horror,
                company: "DreamWorks Pictures",
                description: "It begins as just another urban legend - the whispered tale of a nightmarish videotape that causes anyone who watches it to die seven days later.",
                releaseDate: 2002,
                feedBacks: [],
                filmImages: MovieImages.theRing
            )
        ]
    }
    
}
