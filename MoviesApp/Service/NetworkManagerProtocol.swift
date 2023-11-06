//
//  NetworkManagerProtocol.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchMovie(withId id: String, completion: @escaping (Result<Movie, NetworkError>) -> ())
    func fetchMovies(for searchText: String, completion: @escaping (Result<Movies,NetworkError>) -> ())
}

enum NetworkError: Error {
    case urlError
    case serverError
    case decodingError
    case networkError
}
