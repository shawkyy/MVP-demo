//
//  Networking.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking {
    
    static func getData(URL:URL, completionHandler: @escaping (Data?,URLResponse?,Error?)->Void){
        URLSession.shared.dataTask(with: URL, completionHandler: completionHandler).resume()
    }
    
    public static func fetchMovies(page:Int, shouldFail:Bool = false, completion: @escaping (Result<MoviesDataModel>) -> Void){
        var url:URL?
        if shouldFail {
            url = URL(string: BASE_URL+EndPoints.fallibleMovies.rawValue+"\(page)")
        }else{
            url = URL(string: BASE_URL+EndPoints.movies.rawValue+"\(page)")
        }
        guard let moviesURL = url else {return}
        
        Networking.getData(URL: moviesURL) { (data, response, error) in
            if let data = data {
                do {
                    let moviesObject =  try JSONDecoder().decode(MoviesDataModel.self, from: data)
                    completion(.success(moviesObject))
                } catch {
                    completion(.failure(error))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    public static func downloadImage(url:URL, completion: @escaping (Result<Data>)->()){
        Networking.getData(URL: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
}
