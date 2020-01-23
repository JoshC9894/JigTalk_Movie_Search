//
//  JCResultCell.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 23/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit
import SDWebImage

class JCResultCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 8.0
        cardView.layer.masksToBounds = true
    }
    
    func bindData(_ result: JCSearchResult) {
        titleLabel.text = result.Title
        yearLabel.text = result.Year
        imageView.sd_setImage(with: URL(string: result.Poster), completed: nil)
    }
}
