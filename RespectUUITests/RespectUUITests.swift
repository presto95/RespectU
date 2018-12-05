//
//  RespectUUITests.swift
//  RespectUUITests
//
//  Created by Presto on 05/12/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import XCTest

class RespectUUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.tap()
        
        let element = window.children(matching: .other).element(boundBy: 1)
        element.tap()
        element.tap()
        app.alerts.buttons["OK"].tap()
        app.buttons["nextButton"].tap()
        snapshot("1")
        app.buttons["backButton"].tap()
        snapshot("2")
    }

}
