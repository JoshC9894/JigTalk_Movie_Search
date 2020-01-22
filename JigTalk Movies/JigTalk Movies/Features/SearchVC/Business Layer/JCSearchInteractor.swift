//
//  JCSearchInteractor.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCSearchInteractorProtocol {
}

class JCSearchInteractor: JCSearchInteractorProtocol {
    weak var view: JCSearchViewProtocol?
    var searchService: JCSearchServiceProtocol
    
    init(view: JCSearchViewProtocol) {
        self.view = view
        self.searchService = JCSearchService.shared
    }
    
    // MARK: - Protocol Methods
}
