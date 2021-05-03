//
//  ValidatorTests.swift
//  Chat2chatTests
//
//  Created by Oleksiy on 03.05.2021.
//

import XCTest
@testable import Chat2chat

class ValidatorTests: XCTestCase {
    let validator = Validator()
    
    func testEmptyStrings() {
        XCTAssertNil(validator.validate(string: nil), "Nil should be nil after validation")
        XCTAssertNil(validator.validate(string: ""), "Empty string should be nil after validation")
        XCTAssertNil(validator.validate(string: "  "), "Empty string should be nil after validation")
        XCTAssertNil(validator.validate(string: "\n \n   "), "Empty string should be nil after validation")
    }
    func testValidation() {
        XCTAssertEqual(validator.validate(string: "  Hello world! "), "Hello world!", "Space triming error")
        XCTAssertEqual(validator.validate(string: "Hello world!"), "Hello world!")
        XCTAssertEqual(validator.validate(string: " \n Hello world! \n "), "Hello world!", "Space triming error")
    }
}
