//
//  MoviesPresenter.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

protocol MoviesView: class{
    var presenter: MoviesPresenter? {get set}
    func fetchingDataSuccess()
    func reloadTableView()
    func reloadCollectionView()
}

class MoviesPresenter{
    
    private weak var view: MoviesView?
    private let interactor: MoviesInteractor
    private let router: MoviesRouter
    private var fetchedMovies = [Movie]()
    private var isFetching = false
    private var pageNumber = 2
    private var addedMovies = [UserAddedMovies(title: "Press add button", overview: "", date: "", image: #imageLiteral(resourceName: "Poster"))]
    private var shouldAppendMovie = false
    let sectionNames = ["All movies"]
    
    init(view: MoviesView?, interactor: MoviesInteractor, router: MoviesRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad(){
        getMovies(for: pageNumber)
    }
    
    func getMovies(for page:Int){
        isFetching = true
        interactor.getMovies(for: page) { [weak self](movies, error) in
            guard let self = self else { return }
            if let movies = movies {
                self.fetchedMovies.append(contentsOf: movies.results)
                DispatchQueue.main.async {
                    self.view?.fetchingDataSuccess()
                }
                self.isFetching = false
                self.pageNumber += 1 
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK:- Added movies collectionView
    func addedMoviesCount()->Int{
        return addedMovies.count
    }
    
    func configure(cell: AddedMoviesCollectionViewCell, for index: IndexPath){
        cell.displayTitle(title:addedMovies[index.row].title)
        cell.displayDate(date: addedMovies[index.row].date)
        cell.displayOverview(overview: addedMovies[index.row].overview)
        cell.displayPoster(poster: addedMovies[index.row].image)
    }
    
    //MARK:- All Movies tableView
    func numberOfRowsInSection(for section: Int)->Int{
        return fetchedMovies.count
    }
    
    func configure(cell: MoviesCellView, for index: IndexPath){
        guard let posterpath = fetchedMovies[index.row].posterPath else {return}
        cell.displayTitle(title:fetchedMovies[index.row].title)
        cell.displayDate(date: fetchedMovies[index.row].releaseDate)
        cell.displayOverview(overview: fetchedMovies[index.row].overview)
        cell.displayPoster(poster: POSTER_BASE_URL+posterpath)
    }
    
    func fetchUpcomingCells(for indexPaths: [IndexPath]){
        for index in indexPaths {
            if index.row >= self.fetchedMovies.count - 5 && !isFetching  {
                getMovies(for: pageNumber)
                break
            }
        }
    }
    
    func navigateToAddMovies(){
        router.navigateToAddMoviesScreen(from: view)
    }
    
    func addedMovies(with movies: UserAddedMovies){
        if shouldAppendMovie {
            self.addedMovies.append(movies)
        }else{
            self.addedMovies = [movies]
            shouldAppendMovie = true
        }
        DispatchQueue.main.async {
            self.view?.reloadCollectionView()
        }
    }
}
