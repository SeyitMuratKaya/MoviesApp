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
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getMovie(withId id: String) {
        networkManager.fetchMovie(withId: id) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.delegate?.setMovie(movie: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
