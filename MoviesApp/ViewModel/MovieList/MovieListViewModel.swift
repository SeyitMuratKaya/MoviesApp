//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

class MovieListViewModel {
    private let networkManager: NetworkManagerProtocol
    weak var delegate: MovieListViewDelegate?
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getMovies(for searchText: String){
        let result = searchText.replacingOccurrences(of: " ", with: "+")
        networkManager.fetchMovies(for: result) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.delegate?.setMovies(movies: movies)
            case .failure(_):
                self?.delegate?.setErrors()
            }
        }
    }
}
