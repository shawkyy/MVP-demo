//
//  MoviesTableViewCell.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImagView: UIImageView!

    static let nibName = "MoviesTableViewCell"
    static let cellIdentifier = "MoviesCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MoviesTableViewCell: MoviesCellView{
   
    func displayTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func displayOverview(overview: String) {
        self.overviewLabel.text = overview
    }
    
    func displayDate(date: String) {
        self.dateLabel.text = date

    }
    
    func displayPoster(poster: String) {
        self.posterImagView.loadImage(urlSting: poster)
    }
}
