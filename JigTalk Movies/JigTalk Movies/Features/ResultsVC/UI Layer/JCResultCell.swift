//
//  JCResultCell.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 23/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit

class JCResultCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ result: JCSearchResult) {
        titleLabel.text = result.Title
        yearLabel.text = result.Year
        
    }
}
