//
//  SearchVC.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCSearchViewProtocol: class {
}

class JCSearchVC: UIViewController {
    
    lazy var interactor: JCSearchInteractorProtocol = {
        let interactor = JCSearchInteractor(view: self)
        return interactor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.search(query: "batman")
    }
}

// MARK: - Implement SearchViewProtocol
extension JCSearchVC: JCSearchViewProtocol {
    
}
