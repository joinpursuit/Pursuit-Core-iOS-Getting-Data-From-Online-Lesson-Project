//
//  GettingDataFromOnlineTests.swift
//  GettingDataFromOnlineTests
//
//  Created by Benjamin Stone on 8/28/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import XCTest
@testable import GettingDataFromOnline

class GettingDataFromOnlineTests: XCTestCase {
    func testJokeDecoding() {
        // Arrange
        let jokeJSONData =
        """
        [
          {
            "id": 72,
            "type": "programming",
            "setup": "I was gonna tell you a joke about UDP...",
            "punchline": "...but you might not get it."
          },
          {
            "id": 60,
            "type": "programming",
            "setup": "A user interface is like a joke.",
            "punchline": "If you have to explain it then it is not that good."
          },
        ]
        """.data(using: .utf8)!
        
        // Act
        let jokes = try? JSONDecoder().decode([Joke].self, from: jokeJSONData)

        // Assert
        XCTAssertEqual(jokes?.count, 2, "Error: was expecting 2 jokes, but received \(String(describing: jokes?.count))")
    }
}
