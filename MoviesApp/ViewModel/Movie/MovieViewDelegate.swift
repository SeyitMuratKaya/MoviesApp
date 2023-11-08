//
//  MovieViewDelegate.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

protocol MovieViewDelegate: AnyObject {
    func setMovie(movie: Movie)
    func setErrors()
}
