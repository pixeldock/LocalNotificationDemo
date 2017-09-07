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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    func testIfLocalNotificationIsDisplayed() {
        let app = XCUIApplication()
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        app.launch()
        
        // close app to trigger local notification
        XCUIDevice.shared.press(XCUIDevice.Button.home)

        let localNotification = springboard.otherElements["USERNOTIFICATION, now, Buy milk!, Remember to buy milk from store!"]
        XCTAssertEqual(waiterResultWithExpectation(localNotification), XCTWaiter.Result.completed)
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
