//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

class WebManager: NetworkManagerProtocol {
    func fetchMovies(for searchText: String, completion: @escaping (Result<Movies, NetworkError>) -> ()) {
        guard let url = URL(string: Constants.Paths.baseUrl + Keys.apiKey + Constants.Paths.search + searchText ) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
            }
            
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(Movies.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func fetchMovie(withId id: String, completion: @escaping (Result<Movie, NetworkError>) -> ()) {
        guard let url = URL(string: Constants.Paths.baseUrl + Keys.apiKey + Constants.Paths.id + id ) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
            }
            
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(Movie.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
