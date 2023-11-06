//
//  LocalManager.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

class LocalManager: NetworkManagerProtocol {
    func fetchMovie(withId id: String, completion: @escaping (Result<Movie, NetworkError>) -> ()) {
    }
}
