//
//  SearchService.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol {
}

class SearchService: SearchServiceProtocol {
    static let shared: SearchServiceProtocol = SearchService()
}
