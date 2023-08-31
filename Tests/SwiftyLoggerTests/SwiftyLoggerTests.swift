import XCTest
@testable import SwiftyLogger

final class SwiftyLoggerTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyLogger().text, "Hello, World!")
    }
}
