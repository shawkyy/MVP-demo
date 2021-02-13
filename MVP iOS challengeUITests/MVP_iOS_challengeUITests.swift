//
//  MVP_iOS_challengeUITests.swift
//  MVP iOS challengeUITests
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import XCTest

class MVP_iOS_challengeUITests: XCTestCase {
   
    var moviesChallengeApp: XCUIApplication!

    func testDatePickerView(){
        moviesChallengeApp = XCUIApplication()
        moviesChallengeApp.launch()
        
        let app = XCUIApplication()
        app.navigationBars["MVP_iOS_challenge.MoviesView"].buttons["Add"].tap()
        app.textFields["Date"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
                
    }
    
    func testAddingMovie() throws {
        // UI tests must launch the application that they test.
        moviesChallengeApp = XCUIApplication()
        moviesChallengeApp.launch()
        
        let app = XCUIApplication()
        app.navigationBars["MVP_iOS_challenge.MoviesView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        let overviewTextField = app.textFields["Overview"]
        overviewTextField.tap()
        overviewTextField.tap()
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Add movie"].tap()
      
    }
    
    func testEmptyTextFieldsDismissing(){
        moviesChallengeApp = XCUIApplication()
        moviesChallengeApp.launch()
        
        let app = XCUIApplication()
        app.navigationBars["MVP_iOS_challenge.MoviesView"].buttons["Add"].tap()
        
        let addMovieStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Add movie"]/*[[".buttons[\"Add movie\"].staticTexts[\"Add movie\"]",".staticTexts[\"Add movie\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addMovieStaticText.tap()
        addMovieStaticText.tap()
        addMovieStaticText.tap()
 
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
