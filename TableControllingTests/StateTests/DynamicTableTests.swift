import XCTest
@testable import TableControlling

class DynamicTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: DynamicTable<None, None, None, None, None>!
    var rhs: DynamicTable<None, None, None, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothLoading_true() {
        (lhs, rhs) = (.loading, .loading)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplaying_sameTable_true() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create()))
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplaying_differentTables_false() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create(sections: [.create()])))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_oneReadyOneLoading_false() {
        (lhs, rhs) = (.ready, .loading)
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_bothFailed_sameError_true() {
        enum Failure: Error { case bees }
        (lhs, rhs) = (.failed(Failure.bees), .failed(Failure.bees))
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothFailed_differentErrors_false() {
        enum Failure: Error { case ants, bears }
        (lhs, rhs) = (.failed(Failure.ants), .failed(Failure.bears))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
}
