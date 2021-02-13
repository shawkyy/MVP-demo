//
//  MVP_iOS_challengeTests.swift
//  MVP iOS challengeTests
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import XCTest
@testable import MVP_iOS_challenge

class MVP_iOS_challengeTests: XCTestCase {
    

    func testFetchingMovies(){
        let expectation = XCTestExpectation(description: "Data is fetched successfully")
        Networking.fetchMovies(page: 2) { (result) in
            switch result{
            case .success(_):
                expectation.fulfill()
            case.failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 6)
    }
    
    func testDownloadingImages()  {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg") else {return}
        let expectation = XCTestExpectation(description: "image is fetched successfully")
        Networking.downloadImage(url: imageURL) { (result) in
            switch result {
            case .success(_):
                expectation.fulfill()
            case.failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 6)
    }
    
    func testFetchingMoviesFail(){
        let expectation = XCTestExpectation(description: "Data is fetched successfully")
        Networking.fetchMovies(page: 2, shouldFail: true) { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case.failure(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 6)
    }
    
    func testMoviesInteractor(){
        let interactor = MoviesInteractor()
        interactor.getMovies(for: 2) {(movies, error) in
            XCTAssertNil(error, "no errors")
        }
    }
    
    func testMoviesRouter(){
        let moviesViewController = MoviesRouter.createMoviesViewController()
        XCTAssertNotNil(moviesViewController)
    }
    
    func testAddingMoviesRouter(){
        guard let moviesViewController = MoviesRouter.createMoviesViewController() as? MoviesView else{return}
        let viewController = AddingMoviesRouter.createAddMoviesViewController(with: moviesViewController)
        XCTAssertNotNil(viewController)
    }
    func testAddMoviePresenter(){
        let presenter = AddingMoviesPresenter(view: AddingMoviesViewController(), router: AddingMoviesRouter(), moviesView: MoviesViewController())
        presenter.addMovie(with: UserAddedMovies(title: "", overview: "", date: "", image: UIImage()))
        XCTAssertNotNil(presenter.movie)
    }
}
