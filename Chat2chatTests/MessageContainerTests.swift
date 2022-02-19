//
//  MessageContainerTests.swift
//  Chat2chatTests
//
//  Created by Oleksiy on 03.05.2021.
//

import XCTest
@testable import Chat2chat

class MessageContainerTests: XCTestCase {
    private let container = MessageContainer()

    func testSetMessages() {
        container.setMessages([
            Message(text: "hello world0", fromMe: false),
            Message(text: "hello world1", fromMe: true),
            Message(text: "hello world2", fromMe: false),
            Message(text: "hello world3", fromMe: true)
        ])
        XCTAssertTrue(container.allMessages == [
            Message(text: "hello world0", fromMe: false),
            Message(text: "hello world1", fromMe: true),
            Message(text: "hello world2", fromMe: false),
            Message(text: "hello world3", fromMe: true)
        ], "Setting error")
        
        container.clearMessages()
        XCTAssertTrue(container.isEmpty, "Messages clear error")
    }
    
    func testInsertingByOne() {
        container.clearMessages()
        
        container.addMessage(Message(text: Constants.Messages.chatStartMessage, fromMe: false))
        XCTAssertTrue(container.allMessages == [Message(text: Constants.Messages.chatStartMessage, fromMe: false)], "Set first message error")
        
        container.addMessage(Message(text: "Hello world!", fromMe: true))
        XCTAssertTrue(container.allMessages == [Message(text: "Hello world!", fromMe: true)], "Set second message error")
        
        for i in 1..<3 {
            container.addMessage(Message(text: "Hello world! \(i)", fromMe: true))
        }
        XCTAssertTrue(container.allMessages == [
            Message(text: "Hello world!", fromMe: true),
            Message(text: "Hello world! 1", fromMe: true),
            Message(text: "Hello world! 2", fromMe: true)
        ], "Multiple insertion error")
        
        container.clearMessages()
        XCTAssertTrue(container.isEmpty)
    }
}
