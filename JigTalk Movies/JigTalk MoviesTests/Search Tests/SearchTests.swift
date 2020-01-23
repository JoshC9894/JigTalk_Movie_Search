//
//  SearchTests.swift
//  JigTalk MoviesTests
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import XCTest
@testable import JigTalk_Movies

// MARK: - View Controller Tests
class JCSearchVCTests: XCTestCase {

    var sut: JCSearchVC!
    var window: UIWindow!
    
    override func setUp() {
        window = UIWindow()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "JCSearchVC")
    }
    
    func testViewDidLoad() {
        window.addSubview(sut.view)
        
        XCTAssertEqual(sut.state, JCScreenState.display)
        XCTAssertFalse(sut.searchButton.isHidden)
        XCTAssertFalse(sut.searchButton.isEnabled)
        XCTAssertTrue(sut.activityIndicator.isHidden)
        XCTAssertFalse(sut.activityIndicator.isAnimating)
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    func testLoadingState() {
        window.addSubview(sut.view)
        
        sut.state = .loading
        
        XCTAssertTrue(sut.searchButton.isHidden)
        XCTAssertFalse(sut.activityIndicator.isHidden)
        XCTAssertTrue(sut.activityIndicator.isAnimating)
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    func testErrorState() {
        window.addSubview(sut.view)
        let errorMessage: String = "Server error"
        let error: JCServerError = JCServerError(Error: errorMessage)
        
        sut.displayError(error)
        
        XCTAssertFalse(sut.searchButton.isHidden)
        XCTAssertTrue(sut.searchButton.isEnabled)
        XCTAssertTrue(sut.activityIndicator.isHidden)
        XCTAssertFalse(sut.activityIndicator.isAnimating)
        XCTAssertFalse(sut.errorLabel.isHidden)
        XCTAssertEqual(sut.errorLabel.text, errorMessage)
    }
}

// MARK: - Interactor Tests
class JCSearchInteractorTests: XCTestCase {
    
    var sut: JCSearchInteractor!
    var viewSpy: JCSearchViewSpy = JCSearchViewSpy()
    var searchServiceSpy: JCSearchServiceSpy = JCSearchServiceSpy()
    var testQueue: DispatchQueue = DispatchQueue(label: "test")
    
    override func setUp() {
        sut = JCSearchInteractor(view: viewSpy)
        sut.searchService = searchServiceSpy
        sut.queue = testQueue
    }
    
    func testSuccessfulSearch() {
        let query = "Nightmare Before Christmas"
        let result = JCSearchResult(Title: "Nightmare Before Christmas", Year: "1993", Poster: "imageURL", imdbID: "movieId")
        searchServiceSpy.result = result
        
        sut.search(query: query)
        
        testQueue.sync {}
        XCTAssertTrue(viewSpy.didCallDisplayResults)
        XCTAssertEqual(result.Title, viewSpy.result!.Title)
        XCTAssertEqual(result.Year, viewSpy.result!.Year)
        XCTAssertEqual(result.Poster, viewSpy.result!.Poster)
        XCTAssertEqual(result.imdbID, viewSpy.result!.imdbID)
    }
    
    func testFailingSearch() {
        let query = "J"
        let error = JCServerError(Error: "Too many results")
        searchServiceSpy.error = error
        
        sut.search(query: query)
        
        testQueue.sync {}
        
        XCTAssertTrue(viewSpy.didCallDisplayError)
    }
}

// MARK: - Mocks
class JCSearchViewSpy: JCSearchViewProtocol {
    var didCallDisplayResults: Bool = false
    var didCallDisplayError: Bool = false
    var result: JCSearchResult?
    
    func displayResults(_ results: [JCSearchResult]) {
        didCallDisplayResults = true
        result = results.first
    }
    
    func displayError(_ error: JCServerError) {
        didCallDisplayError = true
    }
}

class JCSearchServiceSpy: JCSearchServiceProtocol {
    var didCallSearch: Bool = false
    var error: JCServerError?
    var result: JCSearchResult?
    
    func search(query: String, completion: @escaping (JCServerResponse<[JCSearchResult]>) -> Void) {
        didCallSearch = true
        if let result = result {
            completion(JCServerResponse.success([result])); return
        }
        
        if let error = error {
            completion(JCServerResponse.failed(error)); return
        } else {
            completion(JCServerResponse.failed(JCServerError(Error: "Generic failure")))
        }
    }
}
