//
//  CellsProtocols.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/20/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

protocol MoviesCellView {
    func displayTitle(title: String)
    func displayOverview(overview: String)
    func displayDate(date: String)
    func displayPoster(poster:String)
}

protocol AddedMoviesCellView {
     func displayTitle(title: String)
      func displayOverview(overview: String)
      func displayDate(date: String)
      func displayPoster(poster:UIImage)
}
