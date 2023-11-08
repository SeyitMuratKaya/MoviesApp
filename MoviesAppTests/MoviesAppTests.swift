//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import XCTest
@testable import MoviesApp

final class MoviesAppTests: XCTestCase {
    
    private var webManager: MockNetworkManager!
    
    // Movie View Controller
    private var movieViewModel: MovieViewModel!
    private var movieViewDelegate: MockMovieViewDelegate!
    
    // Movie List View Controller
    private var movieListViewModel: MovieListViewModel!
    private var movieListViewDelegate: MockMovieListViewDelegate!
    
    override func setUpWithError() throws {
        webManager = MockNetworkManager()
        
        movieViewModel = MovieViewModel(networkManager: webManager)
        movieViewDelegate = MockMovieViewDelegate()
        movieViewModel.delegate = movieViewDelegate
        
        movieListViewModel = MovieListViewModel(networkManager: webManager)
        movieListViewDelegate = MockMovieListViewDelegate()
        movieListViewModel.delegate = movieListViewDelegate
    }

    override func tearDownWithError() throws {
        webManager = nil
        movieViewModel = nil
    }

    func testMovieView_whenApiSuccess_showMovie() throws {
        let mockMovie = Movie(title: "Cars", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: "")
        
        webManager.fetchMovieMockResult = .success(mockMovie)
        movieViewModel.getMovie(withId: "tt1111")
        
        XCTAssertEqual(movieViewDelegate.movie?.title, mockMovie.title)
    }
    
    func testMovieView_whenApiFailure_showsNil() throws {
        webManager.fetchMovieMockResult = .failure(NetworkError.networkError)
        
        movieViewModel.getMovie(withId: "tt1111")
        
        XCTAssertEqual(movieViewDelegate.movie?.title, nil)
    }
    
    func testMovieListView_whenApiSuccess_showMovies() throws {
        let mockMovies = Movies(search: [], totalResults: "2", response: "")
        
        webManager.fetchMoviesMockResult = .success(mockMovies)
        movieListViewModel.getMovies(for: "")
        
        XCTAssertEqual(movieListViewDelegate.movies?.totalResults, mockMovies.totalResults)
    }
    
    func testMovieListView_whenApiFailure_showsNotFound() throws {
        webManager.fetchMoviesMockResult = .failure(NetworkError.networkError)
        
        movieListViewModel.getMovies(for: "")
        
        XCTAssertEqual(movieListViewDelegate.movies?.totalResults, nil)
    }
    
}

class MockNetworkManager: NetworkManagerProtocol {
    var fetchMovieMockResult: Result<MoviesApp.Movie, MoviesApp.NetworkError>?
    var fetchMoviesMockResult: Result<MoviesApp.Movies, MoviesApp.NetworkError>?
    
    func fetchMovie(withId id: String, completion: @escaping (Result<MoviesApp.Movie, MoviesApp.NetworkError>) -> ()) {
        if let result = fetchMovieMockResult {
            completion(result)
        }
    }
    
    func fetchMovies(for searchText: String, completion: @escaping (Result<MoviesApp.Movies, MoviesApp.NetworkError>) -> ()) {
        if let result = fetchMoviesMockResult {
            completion(result)
        }
    }
}

class MockMovieViewDelegate: MovieViewDelegate {
    var movie: Movie?
    
    func setMovie(movie: MoviesApp.Movie) {
        self.movie = movie
    }
    
    func setErrors() {
        self.movie = nil
    }
    
}

class MockMovieListViewDelegate: MovieListViewDelegate {
    var movies: Movies?
    
    func setMovies(movies: MoviesApp.Movies) {
        self.movies = movies
    }
    
    func setErrors() {
        self.movies = nil
    }
}
