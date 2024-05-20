//
//  ChequeViewControllerUITests.swift
//  ChequeViewControllerUITests
//
//  Created by DeadCool23 on 20.05.2024.
//

import XCTest

final class ChequeViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testTapChangeButtonShowsActionSheet() throws {
        let changeButton = app.buttons["changeButton"]
        XCTAssertTrue(changeButton.exists, "The change button should exist")
        
        changeButton.tap()
        
        let cameraOption = app.sheets.buttons["Камера"]
        let galleryOption = app.sheets.buttons["Галерея"]
        let cancelOption = app.sheets.buttons["Отменить"]
        
        XCTAssertTrue(cameraOption.exists, "The camera option should exist in the action sheet")
        XCTAssertTrue(galleryOption.exists, "The gallery option should exist in the action sheet")
        XCTAssertTrue(cancelOption.exists, "The cancel option should exist in the action sheet")
    }

    func testCameraOptionPresentsCamera() throws {
        let changeButton = app.buttons["changeButton"]
        XCTAssertTrue(changeButton.exists, "The change button should exist")
        
        changeButton.tap()
        
        let cameraOption = app.sheets.buttons["Камера"]
        XCTAssertTrue(cameraOption.exists, "The camera option should exist in the action sheet")
        
        cameraOption.tap()
    }

    func testGalleryOptionPresentsPhotoLibrary() throws {
        let changeButton = app.buttons["changeButton"]
        XCTAssertTrue(changeButton.exists, "The change button should exist")
        
        changeButton.tap()
        
        let galleryOption = app.sheets.buttons["Галерея"]
        XCTAssertTrue(galleryOption.exists, "The gallery option should exist in the action sheet")
        
        galleryOption.tap()
    }

    func testDidTapImageShowsPhotoGallery() throws {
        let chequeImage = app.images["chequeImage"]
        XCTAssertTrue(chequeImage.exists, "The cheque image should exist")
        
        chequeImage.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app.launch()
            }
        }
    }
}
