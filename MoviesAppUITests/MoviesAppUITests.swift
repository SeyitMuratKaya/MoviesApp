//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import XCTest

final class MoviesAppUITests: XCTestCase {

    func testSearchMovie() throws {
        let app = XCUIApplication()
        app.launch()
       
        let searchBar = app.navigationBars["MoviesApp.MovieListView"].searchFields["Search Movies"]
        let searchButton = app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"Ara\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        
        searchBar.tap()
        searchBar.typeText("Cars")
        searchButton.tap()
        
        let searchedMovie = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Cars")/*[[".cells.containing(.staticText, identifier:\"(2006)\")",".cells.containing(.staticText, identifier:\"Cars\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 1)
        
        XCTAssertTrue(searchedMovie.exists)
    }
    
    func testUnexistingMovie() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchBar = app.navigationBars["MoviesApp.MovieListView"].searchFields["Search Movies"]
        let searchButton = app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"Ara\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        
        searchBar.tap()
        searchBar.typeText("NotARealMovie")
        searchButton.tap()
        
        let searchedMovie = app.tables.cells.containing(.staticText, identifier:"NotARealMovie").children(matching: .other).element(boundBy: 1)
        
        XCTAssertFalse(searchedMovie.exists)
    }
}
