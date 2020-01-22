//
//  SearchInteractor.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol {
}

class SearchInteractor: SearchInteractorProtocol {
    weak var view: SearchViewProtocol?
    var searchService: SearchServiceProtocol
    
    init(view: SearchViewProtocol) {
        self.view = view
        self.searchService = SearchService.shared
    }
    
    // MARK: - Protocol Methods
}
