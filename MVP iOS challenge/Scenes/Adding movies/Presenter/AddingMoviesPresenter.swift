//
//  AddingMoviesPresenter.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/19/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import UIKit

protocol AddingMoviesView: class {
    var presenter: AddingMoviesPresenter? {get set}
}

class AddingMoviesPresenter {
    
    private weak var view: AddingMoviesView?
    private let router: AddingMoviesRouter
    internal var movie: UserAddedMovies?
    private weak var moviesView: MoviesView?
    
    init(view: AddingMoviesView?, router: AddingMoviesRouter, moviesView: MoviesView) {
        self.view = view
        self.router = router
        self.moviesView = moviesView
    }
    
    func addMovieButtonDidTap(title:String, overview:String, date:String, image:UIImage){
        guard let view = view, let moviesView = moviesView else {return}
        let movie =  UserAddedMovies(title: title, overview: overview, date: date, image: image)
        router.navigateToMovies(from: view, with: movie)
        moviesView.presenter?.addedMovies(with: movie)
        moviesView.reloadTableView()
    }
    
    func addMovie(with movie: UserAddedMovies){
        self.movie = movie
    }
}


