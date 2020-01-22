//
//  JCSearchResult.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

struct JCSearchResult: Codable {
    var Title: String
    var Year: String
    var Released: String
    var Genre: String
    var Director: String
    var Actors: String
    var Plot: String
    var Poster: String
    var Ratings: [JCSearchResultRating]
}

struct JCSearchResultRating: Codable {
    var Source: String
    var Value: String
}
