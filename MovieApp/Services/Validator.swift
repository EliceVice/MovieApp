//
//  Validator.swift
//  MovieApp
//
//  Created by Andrei Isayenka on 02/10/2023.
//

import Foundation

class Validator {
    
    static func checkIsReviewValid(review: String) -> Bool {
        let reviewRegex = "^.{20,}$"
        let regexPred = NSPredicate(format: "SELF MATCHES %@", reviewRegex)
        return regexPred.evaluate(with: review)
    }
}
