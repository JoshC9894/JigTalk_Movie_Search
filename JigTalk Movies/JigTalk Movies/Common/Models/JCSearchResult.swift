//
//  JCSearchResult.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

struct JCSearchResultDTO: Codable {
    var Search: [JCSearchResult]
}

struct JCSearchResult: Codable {
    var Title: String
    var Year: String
    var Poster: String
    var imdbID: String
}
