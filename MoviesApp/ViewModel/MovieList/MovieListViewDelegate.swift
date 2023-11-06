//
//  MovieListViewDelegate.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

protocol MovieListViewDelegate: AnyObject {
    func setMovies(movies: Movies)
    func setErrors()
}
