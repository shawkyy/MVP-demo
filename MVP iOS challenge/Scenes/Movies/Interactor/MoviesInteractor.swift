//
//  MoviesInteractor.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

class MoviesInteractor {
    func getMovies(for page:Int, completion: @escaping (MoviesDataModel?,Error?)->()){
        Networking.fetchMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                completion(movies,nil)
            case.failure(let error):
                completion(nil,error)
            }
        }
    }
}
