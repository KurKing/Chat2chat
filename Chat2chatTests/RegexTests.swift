//
//  RegexTests.swift
//  Chat2chatTests
//
//  Created by Oleksiy on 03.05.2021.
//

import XCTest
@testable import Chat2chat

class RegexTests: XCTestCase {

    func testEmail() {
        XCTAssertTrue("1oleksii@gmail.com"~=Constants.Regex.email, "1oleksii@gmail.com should compare to email regex")
        XCTAssertTrue("katya@gmail.com"~=Constants.Regex.email, "katya@gmail.com should compare to email regex")
        XCTAssertTrue("1@2.com"~=Constants.Regex.email, "1oleksii@gmail.com should compare to email regex")
        
        XCTAssertFalse(""~=Constants.Regex.email, "Empty string shouldn't compare to regex")
        XCTAssertFalse("katya.gmail.com"~=Constants.Regex.email, "katya.gmail.com shouldn't compare to email regex")
        XCTAssertFalse("asdfsdf"~=Constants.Regex.email, "asdfsdf shouldn't compare to email regex")
        XCTAssertFalse("123@123"~=Constants.Regex.email, "123@123 shouldn't compare to email regex")
    }
    
    func testPassword() {
        XCTAssertTrue("Kuxnya12345"~=Constants.Regex.password, "Kuxnya12345 should compare to password regex")
        XCTAssertTrue("12345Kuxnya"~=Constants.Regex.password, "12345Kuxnya should compare to password regex")
        XCTAssertTrue("Kux12345ya"~=Constants.Regex.password, "Kux12345ya should compare to password regex")
        
        XCTAssertFalse("123aaaaaaaa"~=Constants.Regex.password, "123aaaaaaaa shouldn't compare password to regex")
        XCTAssertFalse("123AAAAAAAAA"~=Constants.Regex.password, "123AAAAAAAAA shouldn't compare password to regex")
        XCTAssertFalse("aaaaAAAA"~=Constants.Regex.password, "aaaaAAAA shouldn't compare password to regex")
        XCTAssertFalse("12345678"~=Constants.Regex.password, "12345678 shouldn't compare password to regex")
        XCTAssertFalse("AAaa12"~=Constants.Regex.password, "12345678 shouldn't compare password to regex")
    }

}
