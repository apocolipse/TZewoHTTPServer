import XCTest
@testable import TZewoHTTPServer

class TZewoHTTPServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TZewoHTTPServer().text, "Hello, World!")
    }


    static var allTests : [(String, (TZewoHTTPServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
