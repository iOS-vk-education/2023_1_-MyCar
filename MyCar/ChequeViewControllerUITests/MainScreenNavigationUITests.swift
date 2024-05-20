//
//  ChequeViewControllerUITests.swift
//  ChequeViewControllerUITests
//
//  Created by DeadCool23 on 20.05.2024.
//

import XCTest

final class MainScreenNavigationUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testMapScreen() {
        let mapButton = app.buttons["Карта"]
        XCTAssertTrue(mapButton.exists, "The map button should exist")
        mapButton.tap()
        let myLocation = app.otherElements["My Location"]
        XCTAssertTrue(myLocation.exists, "The map button should exist")
    }
    
    func testDocumentsScreen() {
        let documentsButton = app.buttons["Документы"]
        XCTAssertTrue(documentsButton.exists, "The documents button should exist")
        documentsButton.tap()
        let title = app.staticTexts["Документы"]
        XCTAssertTrue(title.exists, "The title should exist")
    }
    
    func testTutorialScreen() {
        let tutorialButton = app.buttons["Руководство"]
        XCTAssertTrue(tutorialButton.exists, "The tutorial button should exist")
        tutorialButton.tap()
        let title = app.staticTexts["Руководство"]
        XCTAssertTrue(title.exists, "The title should exist")
    }
    
    func testOnboardingScreen() {
        let onboardingButton = app.buttons["More Info"]
        XCTAssertTrue(onboardingButton.exists, "The onboarding button should exist")
        onboardingButton.tap()
        let firstImage = app.images["first"]
        XCTAssertTrue(firstImage.exists, "The onboarding screen should exist")
    }
    
    func testAddCarScreen() {
        let addCarButton = app.buttons["add"]
        XCTAssertTrue(addCarButton.exists, "The add car screen should exist")
        addCarButton.tap()
        let title = app.staticTexts["Новый автомобиль"]
        XCTAssertTrue(title.exists, "The add car screen should exist")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app.launch()
            }
        }
    }
}
