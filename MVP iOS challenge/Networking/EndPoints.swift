//
//  EndPoints.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

public enum EndPoints: String {
    case movies = "/3/discover/movie?api_key=95ed30ad4069e54f338db2574273d5d0&page="
    case fallibleMovies = "discover/movie?api_key=5f5356f1890deee66bf4976756b5aba8&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="
}


