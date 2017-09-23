//
//  ArrayTests.swift
//  Array
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import ArrayTests

extension ArrayTests {

	static var allTests : [(String, (ArrayTests) -> () throws -> Void)] {
		return [
			("testComponents", testComponents),
			("testRemoveCondition", testRemoveCondition),
		]
	}

}

XCTMain([
	testCase(ArrayTests.allTests),
])

