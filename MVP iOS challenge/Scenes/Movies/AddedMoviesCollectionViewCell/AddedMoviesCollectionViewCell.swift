//
//  AddedMoviesCollectionViewCell.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/20/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class AddedMoviesCollectionViewCell: UICollectionViewCell {
   
    static let cellNibName = "AddedMoviesCollectionViewCell"
    static let cellIdentifier = "addedMoviesCell"
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.layer.cornerRadius = 5
        parentView.clipsToBounds = true 
    }

}
extension AddedMoviesCollectionViewCell: AddedMoviesCellView {
   
    func displayTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func displayOverview(overview: String) {
        self.overViewLabel.text = overview
    }
    
    func displayDate(date: String) {
        self.dateLabel.text = date

    }
    
    func displayPoster(poster: UIImage) {
        self.posterImageView.image = poster
    }
}
