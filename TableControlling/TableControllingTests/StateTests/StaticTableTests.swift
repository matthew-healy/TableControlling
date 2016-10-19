import XCTest
@testable import TableControlling

class StaticTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: StaticTable<None, None, String, None, None>!
    var rhs: StaticTable<None, None, String, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_oneReadyOneDisplay_false() {
        (lhs, rhs) = (.ready, .display(.create()))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplayMatchingTables_true() {
        lhs = .display(.create())
        rhs = .display(.create())
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplayDifferentTables_false() {
        lhs = .display(.create(sections: [.create()]))
        rhs = .display(.create())
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }

}
