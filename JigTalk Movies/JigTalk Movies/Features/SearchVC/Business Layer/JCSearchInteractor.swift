//
//  JCSearchInteractor.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCSearchInteractorProtocol {
    func search(query: String)
}

class JCSearchInteractor: JCSearchInteractorProtocol {
    weak var view: JCSearchViewProtocol?
    var searchService: JCSearchServiceProtocol
    var queue: DispatchQueue = .main
    
    init(view: JCSearchViewProtocol) {
        self.view = view
        self.searchService = JCSearchService.shared
    }
    
    // MARK: - Protocol Methods
    func search(query: String) {
        searchService.search(query: query) { (response) in
            switch response {
            case .success(let models):
                self.queue.async {
                    self.view?.displayResults(models)
                }
                
            case .failed(let error):
                self.queue.async {
                    self.view?.displayError(error)
                }
            }
        }
    }
}
