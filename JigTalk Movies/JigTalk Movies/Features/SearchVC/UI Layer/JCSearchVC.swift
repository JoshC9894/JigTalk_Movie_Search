//
//  SearchVC.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit

enum JCScreenState {
    case display, error, loading
}

protocol JCSearchViewProtocol: class {
    func displayResults(_ results: [JCSearchResult])
    func displayError(_ error: JCServerError)
}

class JCSearchVC: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var state: JCScreenState! {
        didSet { setState(state) }
    }
    
    lazy var interactor: JCSearchInteractorProtocol = {
        let interactor = JCSearchInteractor(view: self)
        return interactor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2.0
        searchButton.addTarget(self, action: #selector(searchButton_Action), for: .touchUpInside)
        searchField.addTarget(self, action: #selector(searchFieldDidEdit(sender:)), for: .editingChanged)
        activityIndicator.color = .systemGreen
        state = .display
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setState(_ state: JCScreenState) {
        switch state {
        case .display:
            searchButton.isHidden = false
            searchButton.isEnabled = searchField.text != ""
            searchButton.alpha = searchField.text != "" ? 1.0 : 0.45
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            errorLabel.isHidden = true
            
        case .error:
            searchButton.isHidden = false
            searchButton.isEnabled = true
            searchButton.alpha = 1.0
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            errorLabel.isHidden = false
            
        case .loading:
            searchButton.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            errorLabel.isHidden = true
        }
    }
    
    // MARK: - Actions
    @objc private func searchButton_Action() {
        if let query = searchField.text {
            setState(.loading)
            interactor.search(query: query)
        }
    }
    
    @objc private func searchFieldDidEdit(sender: UITextField) {
        setState(.display)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - Implement SearchViewProtocol
extension JCSearchVC: JCSearchViewProtocol {
    func displayResults(_ results: [JCSearchResult]) {
        setState(.display)
        if let vc = storyboard?.instantiateViewController(identifier: "JCResultsVC") as? JCResultsVC {
            vc.results = results
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func displayError(_ error: JCServerError) {
        errorLabel.text = error.Error
        setState(.error)
    }
}
