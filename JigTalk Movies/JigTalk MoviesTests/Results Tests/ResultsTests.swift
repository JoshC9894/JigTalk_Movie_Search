//
//  ResultsTests.swift
//  JigTalk MoviesTests
//
//  Created by Joshua Colley on 23/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import XCTest
@testable import JigTalk_Movies

class ResultsTests: XCTestCase {
    
    var sut: JCResultsVC!
    var window: UIWindow = UIWindow()
    
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "JCResultsVC")
    }
    
    func testViewDidLoad() {
        let result = JCSearchResult(Title: "Nightmare Before Christmas", Year: "1993", Poster: "imageURL", imdbID: "movieId")
        sut.results = [result]
        
        window.addSubview(sut.view)
        sut.collectionView.layoutIfNeeded()
        
        let index = IndexPath(item: 0, section: 0)
        guard let cell = sut.collectionView.cellForItem(at: index) as? JCResultCell else {
            XCTFail("Failed to cast cell"); return
        }
        
        XCTAssertEqual(cell.titleLabel.text, result.Title)
        XCTAssertEqual(cell.yearLabel.text, result.Year)
    }
}
