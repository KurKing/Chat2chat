//
//  LoginScreenUITests.swift
//  LoginScreenUITests
//
//  Created by Oleksiy on 24.06.2021.
//

import XCTest

class LoginScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLogin() throws {
        
        let app = XCUIApplication()
        app.launch()

        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)

        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)

        let logInButton = app.buttons["Log in"]
        XCTAssertTrue(logInButton.exists)

        let deleteKey = app.keys["delete"]
        
        emailTextField.tap()
        deleteKey.press(forDuration: 2);
        XCUIApplication().buttons["Return"].tap()
        deleteKey.press(forDuration: 0.7);
        XCUIApplication().buttons["Return"].tap()
        
        logInButton.tap()

        XCTAssertFalse(app.alerts["Error"].exists)
        
        emailTextField.tap()
        emailTextField.typeText("blablabla")
        XCUIApplication().buttons["Return"].tap()
        passwordSecureTextField.typeText("123")
        XCUIApplication().buttons["Return"].tap()
        
        logInButton.tap()

        XCTAssertTrue(app.alerts["Error"].exists)
        
    }
}
