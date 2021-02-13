//
//  MoviesRouter.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class MoviesRouter {
    class func createMoviesViewController() -> UIViewController {
        
        let moviesviewController = MoviesViewController()
        let mainNavigationController = UINavigationController(rootViewController: moviesviewController)
        mainNavigationController.navigationBar.barTintColor = .systemGray4
        if let moviesView = mainNavigationController.children.first as? MoviesView {
            let router = MoviesRouter()
            let interactor = MoviesInteractor()
            let presenter = MoviesPresenter(view: moviesView, interactor: interactor, router: router)
            moviesView.presenter = presenter
        }
        return mainNavigationController
    }
    
    func navigateToAddMoviesScreen (from view: MoviesView?) {
        guard let view = view else {return}
        let addMoviesView = AddingMoviesRouter.createAddMoviesViewController(with: view)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.present(addMoviesView, animated: true, completion: nil)
        }
    }
}
