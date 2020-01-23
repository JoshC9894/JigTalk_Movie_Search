//
//  JCResultsVC.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 23/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit

class JCResultsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var results: [JCSearchResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "JCResultCell", bundle: nil), forCellWithReuseIdentifier: "JCResultCell")
    }
}

// MARK: - CollectionView Methods
extension JCResultsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JCResultCell", for: indexPath) as? JCResultCell else {
            return UICollectionViewCell()
        }
        cell.bindData(results[indexPath.row])
        return cell
    }
}
