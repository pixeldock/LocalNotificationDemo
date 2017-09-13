//
//  UserNotificationUITests.swift
//  UserNotificationUITests
//
//  Created by Jörn Schoppe on 07.09.17.
//  Copyright © 2017 pixeldock. All rights reserved.
//

import XCTest

class UserNotificationUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testIfLocalNotificationIsDisplayed() {
        let app = XCUIApplication()
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        app.launch()
        
        // close app to trigger local notification
        XCUIDevice.shared.press(XCUIDevice.Button.home)

        // wait for the notification
        let localNotification = springboard.otherElements["USERNOTIFICATION, now, Buy milk!, Remember to buy milk from store!"]
        XCTAssertEqual(waiterResultWithExpectation(localNotification), XCTWaiter.Result.completed)
    }
    
    func testSwitchOffWiFi() {
        let app = XCUIApplication()
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        app.launch()
        
        // open control center
        let coord1 = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.99))
        let coord2 = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        coord1.press(forDuration: 0.1, thenDragTo: coord2)
        
        let wifiButton = springboard.switches["wifi-button"]
        wifiButton.tap()
        
        // close control center
        let coord3 = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        coord3.tap()
        

        
    }
}

extension UserNotificationUITests {
    func waiterResultWithExpectation(_ element: XCUIElement) -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = XCTNSPredicateExpectation(predicate: myPredicate,
                                                      object: element)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 6)
        return result
    }
}

extension XCUIApplication {
    func openNotificationCenter() {
        let coord1 = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.99))
        let coord2 = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        coord1.press(forDuration: 0.1, thenDragTo: coord2)
    }
}
