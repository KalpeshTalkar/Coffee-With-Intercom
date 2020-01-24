//
//  Coffee_With_IntercomTests.swift
//  Coffee With IntercomTests
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import XCTest
@testable import Coffee_With_Intercom

var sut: FileReader!

class Coffee_With_IntercomTests: XCTestCase {

    override func setUp() {
        super.setUp()
        sut = FileReader()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testReadingRemoteCustomers() {
        let promise = expectation(description: "Read Remote Customers")
        sut.readCustomersFromRemoteFile { (customers) in
            if customers.isEmpty {
                XCTFail("Failed to read remote customers")
            } else {
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    func testReadingLocalCustomers() {
        let promise = expectation(description: "Read Local Customers")
        sut.readCustomersFromBundle { (customers) in
            if customers.isEmpty {
                XCTFail("Failed to read local customers")
            } else {
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 2)
    }

    func testPerformance() {
        self.measure {
            testReadingRemoteCustomers()
            testReadingLocalCustomers()
        }
    }

}
