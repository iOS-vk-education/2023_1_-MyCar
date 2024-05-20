//
//  ChequeViewControllerUITestsLaunchTests.swift
//  ChequeViewControllerUITests
//
//  Created by DeadCool23 on 20.05.2024.
//

import XCTest

final class ChequeViewControllerUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let someButton = app.buttons["navigateToChequeViewControllerButton"]
        if someButton.exists {
            someButton.tap()
        }

        let chequeView = app.otherElements["ChequeView"]
        XCTAssertTrue(chequeView.waitForExistence(timeout: 5), "ChequeView should be present")

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "ChequeViewController Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
