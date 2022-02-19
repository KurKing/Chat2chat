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
            MessageViewModel(text: "hello world0", fromMe: false),
            MessageViewModel(text: "hello world1", fromMe: true),
            MessageViewModel(text: "hello world2", fromMe: false),
            MessageViewModel(text: "hello world3", fromMe: true)
        ])
        XCTAssertTrue(container.allMessages == [
            MessageViewModel(text: "hello world0", fromMe: false),
            MessageViewModel(text: "hello world1", fromMe: true),
            MessageViewModel(text: "hello world2", fromMe: false),
            MessageViewModel(text: "hello world3", fromMe: true)
        ], "Setting error")
        
        container.clearMessages()
        XCTAssertTrue(container.isEmpty, "Messages clear error")
    }
    
    func testInsertingByOne() {
        container.clearMessages()
        
        container.addMessage(MessageViewModel(text: Constants.Messages.chatStartMessage, fromMe: false))
        XCTAssertTrue(container.allMessages == [MessageViewModel(text: Constants.Messages.chatStartMessage, fromMe: false)], "Set first message error")
        
        container.addMessage(MessageViewModel(text: "Hello world!", fromMe: true))
        XCTAssertTrue(container.allMessages == [MessageViewModel(text: "Hello world!", fromMe: true)], "Set second message error")
        
        for i in 1..<3 {
            container.addMessage(MessageViewModel(text: "Hello world! \(i)", fromMe: true))
        }
        XCTAssertTrue(container.allMessages == [
            MessageViewModel(text: "Hello world!", fromMe: true),
            MessageViewModel(text: "Hello world! 1", fromMe: true),
            MessageViewModel(text: "Hello world! 2", fromMe: true)
        ], "Multiple insertion error")
        
        container.clearMessages()
        XCTAssertTrue(container.isEmpty)
    }
}
