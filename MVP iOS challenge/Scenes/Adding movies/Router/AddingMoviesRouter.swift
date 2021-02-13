//
//  AddingMoviesRouter.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/19/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class AddingMoviesRouter {
    
    class func createAddMoviesViewController(with view: MoviesView) -> UIViewController {
        let addingMoviesViewController = AddingMoviesViewController()
        let router = AddingMoviesRouter()
        let presenter = AddingMoviesPresenter(view: addingMoviesViewController, router: router, moviesView: view)
        addingMoviesViewController.presenter = presenter
        return addingMoviesViewController
    }
    
    func navigateToMovies(from view:AddingMoviesView, with movie: UserAddedMovies) {
        if let viewController = view as? UIViewController {
            if let moviesView =  viewController.parent as? MoviesView {
                moviesView.presenter?.addedMovies(with: movie)
            }
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
