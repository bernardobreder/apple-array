//
//  Array.swift
//  Array
//
//  Created by Bernardo Breder on 15/01/17.
//
//

import XCTest
@testable import Array

class ArrayTests: XCTestCase {

    func testRemoveCondition() {
        var a = [0,1,2,3,4,5,6,7,8,9]
        XCTAssertEqual([1,3,5,7,9], a.remove(condition: {i,e in i % 2 == 0}))
        XCTAssertEqual([1,3,7,9], a.remove(condition: {i,e in e == 5}))
        XCTAssertEqual([1,7], a.remove(condition: {i,e in e % 3 == 0}))
        XCTAssertEqual([], a.remove(condition: {i,e in true}))
    }
    
    func testComponents() throws {
        XCTAssertEqual("/", [String]().reducePath())
        XCTAssertEqual("/a", ["a"].reducePath())
        XCTAssertEqual("/a/b", ["a", "b"].reducePath())
        XCTAssertEqual("/a/b/c.txt", ["a", "b", "c.txt"].reducePath())
    }

}

