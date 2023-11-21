//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

class MovieViewModel {
    private let networkManager: NetworkManagerProtocol
    weak var delegate: MovieViewDelegate?
    var movieId: String
    
    init(networkManager: NetworkManagerProtocol, movieId: String) {
        self.networkManager = networkManager
        self.movieId = movieId
    }
    
    func getMovie(withId id: String) {
        networkManager.fetchMovie(withId: id) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.delegate?.setMovie(movie: movie)
            case .failure:
                self?.delegate?.setErrors()
            }
        }
    }
}
